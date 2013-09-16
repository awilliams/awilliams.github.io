---
layout: post
title: "On Using Vagrant to Setup a Development Box"
tagline: 
description: "A step-by-step guide for setting up a virtualbox development machine using Vagrant, VeeWee and Librarian"
category: posts
tags: [vagrant, veewee, virtualbox]
---
This guide will show how to setup a VirtualBox similiar to an Ubuntu 12.04.1 server for use with Amazon EC2. 
The VirtualBox can then be used locally to mimic your production environment.

**Covered in this guide:**

* VeeWee: Tool for building base boxes which will be used by vagrant
* Vagrant: Tool for managing virtual machines with an easy to use CLI
* Librarian: Bundler for chef cookbooks
* Chef-solo & Knife solo: Tool for automating installing and management of servers

**Prerequisites not covered in this guide:**

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [RVM](https://rvm.io/)
* [Bundler](http://gembundler.com/) ( `gem install bundler` )

## Initial Setup
We'll create a base directory and make it a RVM and bundler project

    % mkdir systems; cd systems
    % rvm --rvmrc --create 1.9.3@systems
    % cd ..; cd systems # accept the RVM notice
    % ruby -v # ensure that the correct ruby is being used
    % bundle init

Ruby 1.9.3 is used, but for no other reason than it's the latest. Everything should work with other versions as well. 

Edit your Gemfile to include the following gems, or use **[our Gemfile](https://gist.github.com/awilliams/4723391#file-gemfile)**

 * vagrant
 * veewee
 * knife-solo
 * librarian
 * multi_json
 * ruby-shadow

Install the gems
    
    % bundle install

_If bundler fails on ffi library, try commenting out all gems in gemfile except first, and doing bundle install one-by-one._

## VeeWee
> https://github.com/jedi4ever/veewee
> Tool to easily build vagrant base boxes or kvm, virtualbox and fusion images.

We'll use VeeWee to create our Vagrant basebox. The base box is the base virtual machine that can be copied for each project and modified further using chef or puppet per project needs. [More info here](http://docs.vagrantup.com/v2/boxes.html). There are pre built [baseboxes available](http://www.vagrantbox.es/). You could download one and skip this VeeWee section.

First we'll clone the git project into ours. Instead of using submodules, we'll create a subrepository. [More info](http://debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-967e-0e48cbdd56cb)

    % git clone https://github.com/jedi4ever/veewee.git
    
Before cd'ing into this directory, which has it's own .rvmrc file, we'll delete it to use the same rvm project throughout.
    
    % rm veewee/.rvmrc
    % cd veewee

See list of available Ubuntu templates

    % veewee vbox templates | grep -i ubuntu

Next we follow the [instructions from the veewee repo](https://github.com/jedi4ever/veewee/blob/master/doc/vagrant.md). In our example, we'll create an ubuntu-12.04.1-server-amd64.iso machine

_Name should not contain underscores!_
    
    % veewee vbox define 'ubuntu-12.04.1-server-x64' 'ubuntu-12.04.1-server-amd64'

This will create a directory with 3 config files for your box in `definitions/ubuntu-12.04.1-server-x64/`. We'll edit these file to make a few changes:

* cpu_count => 2
* memory => 1024mb
* hostname => devbox
* Removal of various post install commands. We'll instead accomplish the same using chef-solo. This is to create a basebox which more closely resembles a default EC2 instance.

cd into definition directory, then into the directory of your template (name is the same as you defined previously). 
    
    $ cd definitions/ubuntu-12.04.1-server-x64/

Edit the definition files accordingly. Our definition files: 
 * [definition.rb](https://gist.github.com/awilliams/4723391#file-definition-rb)
 * [postinstall.sh](https://gist.github.com/awilliams/4723391#file-postinstall-sh)
 * No changes in the preseed.cfg file

**Update** The new version of VeeWee has new (better) format for the 'definition.rb' file and breaks apart the post install script (*postinstall.sh*) into multiple files. For this install, I left out the "ruby.sh", "chef.sh", and "puppet.sh" postinstall files, which can just be commented out of the defintions.rb file. 

No we are ready to build the VM box. **Good time to get a coffee while executing the following**

    % veewee vbox build ubuntu-12.04.1-server-x64

The `validate` command **will fail** as we've removed things from the postinstall. You can run it anyways

    % veewee vbox validate 'ubuntu-12.04.1-server-x64'

Export the box into Vagrant _.box_ format

    % vagrant basebox export 'ubuntu-12.04.1-server-x64'

Add box to vagrant

    % vagrant box add 'ubuntu-12.04.1-server-x64' 'ubuntu-12.04.1-server-x64.box'
    % vagrant box list # should list box

This completes our use of VeeWee to create the base Vagrant box. We'll now work in the base directory

    % cd ..

## Vagrant 
> http://www.vagrantup.com/
> Create and configure lightweight, reproducible, and portable development environments.

Install NFS support on host

    % sudo apt-get install nfs-common nfs-kernel-server

Init directory as vagrant project

    % vagrant init 'ubuntu-12.04.1-server-x64'
    
This will create a `Vagrantfile`. Edit the file to define the ports which will be open on the VM, and any post installation instructions. Vagrant integrates with Chef or Puppet, running the provisioner automatically. In our case, we'll do all this manually with knife solo to better replicate an EC2 instance. 

See [our Vagrantfile](https://gist.github.com/awilliams/4723391#file-vagrantfile) for example config, which creates a NFS share on the VM. The host directory must exist before doing next step.

Startup VM box. By default, the VM is headless so you won't see the typical VM window.

    % vagrant up

SSH into box
    
    % vagrant ssh
    vagrant@devbox:~$ uname -m # 64bit
    x86_64
    vagrant@devbox:~$ cat /proc/cpuinfo # 2 cpus
    ...
    vagrant@devbox:~$ logout

## Librarian
> Librian will manage our chef cookbooks and their dependencies
> https://github.com/applicationsonline/librarian

Since Librarian takes over control of the `cookbooks` directory, we'll make sure it's not added to version control.

    % git rm -r cookbooks
    % echo /cookbooks >> .gitignore
    % echo /tmp >> .gitignore 

Init directory with knife solo, will create default chef directory structure

    % knife solo init .

Init librarian

    % librarian-chef init

Edit the `Chefile` with the cookbooks you wish to use. See [our Cheffile](https://gist.github.com/awilliams/4723391#file-cheffile) for an example. Opscode maintains a repository of cookbooks, similiar to rubygems for bundler. http://community.opscode.com/cookbooks/ 

To create a new cookbook

    % knife cookbook create mylocalcookbook -o site-cookbooks

Place any cookbooks which are not in accesible by git in the `site-cookbooks` directory. Use them in your Cheffile with the `:path` parameter.
<pre>
cookbook 'mylocalcookbook'
  :path => 'site-cookbooks/mylocalcookbook'
</pre>

Run librian update which downloads (or copies in the case of local cookbooks) into your `cookbooks` directory.
    
    % librarian-chef install
    
## Knife-solo + Chef-solo
> Chef-solo executes the cookbooks without the need for a Chef-server. Knife-solo runs Chef-solo remotely, in this case, on our VM
> http://wiki.opscode.com/display/chef/Chef+Solo
> https://github.com/matschaffer/knife-solo

Bootstrap virtual machine for use with Chef solo. This connects via ssh to the VM and installs the chef package.

    % knife solo prepare vagrant@33.33.33.10 -P vagrant -V

**Note**: When using Ubuntu 13.04, the `prepare` command fails. See [this ticket](http://tickets.opscode.com/browse/CHEF-4142). The easy workaround is [manually installing Chef on the guest machine](http://www.opscode.com/chef/install/). 
    
### Creating Chef roles and nodes
> **Roles**: "A role provides a means of grouping similar features of similar nodes, providing a mechanism for easily composing sets of functionality." [- Chef website](http://wiki.opscode.com/display/chef/Roles)
> **Nodes**: "A node is a host that runs the Chef client. The primary features of a node, from Chef's point of view, are its attributes and its run list. Nodes are the thing that Recipes and Roles are applied to. In practice, there is usually a one-to-one mapping between a node and a physical device (a computer, a switch, a router, etc.), but in special > cases a system may execute the recipes for multiple nodes." [- Chef website](http://wiki.opscode.com/display/chef/Nodes)

To create a role, create a file with the name of your role in the `roles` directory. See [example role](https://gist.github.com/awilliams/4723391#file-dev-rb). The specifics of this file are outside the scope of this guide.

Next, create a node definition for our VM, ie `nodes/devbox.json`. In our case, this will just be a reference to the previously created role. [devbox.json](https://gist.github.com/awilliams/4723391#file-devbox-json)

To copy over our cookbooks and definitions to the VM, but not actually run chef-solo, use the following command. This is useful for debugging cookbooks.

    % knife solo cook vagrant@33.33.33.10 -P vagrant -V --sync-only

Run chef-solo on virtual machine. First SSH into virutal machine

    % vagrant ssh

Librarian transfers everything in the VM to ~/chef-solo

    % vagrant@devbox:~$ cd ~/chef-solo/

_While testing, it can be useful to run an individual cookbook or role_

    % vagrant@devbox:/tmp/chef-solo$ sudo chef-solo -l debug -o "recipe[myrecipe]" -c solo.rb # runs 1 recipe
    % vagrant@devbox:/tmp/chef-solo$ sudo chef-solo -l debug -o "role[dev]" -c solo.rb # runs 1 role
    
To run the node definition

    % vagrant@devbox:/tmp/chef-solo$ sudo chef-solo -l debug -o "role[dev]" -c solo.rb
    
To sync the cookbook and run chef-solo **from the VM host**

    % knife solo cook vagrant@33.33.33.10 -P vagrant -V -c solo.rb -N devbox
