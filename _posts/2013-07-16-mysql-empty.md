---
layout: post
title: "Drop all tables in MySQL DB"
tagline:
description: "Quick shell command to drop all tables in MySQL database"
category: articles
tags: [MySQL]
---

This will drop all tables in given database. See the ServerFault page if any tables have foreign key constraints.

{% highlight bash %}
mysqldump -u[USERNAME] -p[PASSWORD] --add-drop-table --no-data [DATABASE] | grep ^DROP | mysql -u[USERNAME] -p[PASSWORD] [DATABASE]
{% endhighlight %}

--------------------

Source: [ServerFault](http://serverfault.com/questions/82165/how-to-drop-all-tables-in-a-mysql-database-without-dropping-the-database)
