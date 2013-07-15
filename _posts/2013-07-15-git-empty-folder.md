---
layout: post
title: "Empty folders in git"
tagline: 
category: articles
tags: [git]
---

There are two situations that can arise when using git and working with empty directories.

 * You'd like to add an empty folder to git, which will later contain files which themselves will be added to git. This could occur if you're creating the directory  layout for a project. Solution: **Just add an empty file called .keep to the directory**
{% highlight bash %}
touch path/to/empty/dir/.keep; git add path/to/empty/dir/.keep
{% endhighlight %}

 *  You'd like to an an empty folder to git, but an files created inside of it should be ignored. This could occur if you're creating a `logs` directory for example. Solution: **Add a .gitignore file inside the directory with the following contents**
{% highlight bash %}
*
!.gitignore
{% endhighlight %}

--------------------

Sources: [StackOverflow](http://stackoverflow.com/a/5581995/291395) and [Rails](https://github.com/rails/rails/blob/4-0-stable/railties/lib/rails/generators/app_base.rb#L286)
