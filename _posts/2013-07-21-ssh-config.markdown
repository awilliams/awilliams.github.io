---
layout: post
title: "ssh config file"
tagline:
description: "helpful config file for ssh client"
category: articles
tags: [ssh]
---

The ssh client uses the `~/.ssh/config` file for configuration data. If you ssh into servers often, it's a great place to keep options you'd otherwise add to a bash aliases or just enter each time.

Verbose example (no config):
{% highlight bash %}
ssh ubuntu@ec2-64-147-200-103.eu-west-1.compute.amazonaws.com -i ~/.ssh/Amazon.pem
{% endhighlight %}

Could be shortened to (with config):
{% highlight bash %}
ssh my-ec2-server
{% endhighlight %}

Add the following to the file `~/.ssh/config` (you may need to create the file first)
{% highlight bash %}
Host my-ec2-server
        HostName ec2-64-147-200-103.eu-west-1.compute.amazonaws.com
        User ubuntu
        IdentityFile ~/.ssh/amazon.pem
{% endhighlight %}

Many more options are possible in `~/.ssh/config`. See [`man 5 ssh_config`](http://linux.die.net/man/5/ssh_config)

----------------

Sources: [man 5 ssh_config](http://linux.die.net/man/5/ssh_config), [Simplify Your Life With an SSH Config File](http://nerderati.com/2011/03/simplify-your-life-with-an-ssh-config-file/)