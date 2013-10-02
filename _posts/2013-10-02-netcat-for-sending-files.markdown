---
layout: post
title: "Netcat for sending files"
tagline:
description: "Quick hack to send files over the local network"
category: articles
tags: []
---

Jesse Storimer recently shared as part of his informative emails "[Working With Code](http://eepurl.com/uYkXL)" how to easily send files over the local network using the command line.

*The Receiver should enter*
{% highlight bash %}
nc -l 5566 > large_file.sql 
{% endhighlight %}

where `5566` is an arbitrary open port, and `large_file.sql` is the name of the file (this could be different than the sender's file name). This command will then block until it receives all the file.

*The Sender should then enter*
{% highlight bash %}
nc <receiver-ip-address> 5566 < big_file.sql
{% endhighlight %}

Where `5566` is the same port as the receiver and `big_file.sql` is the file to send. Make sure to get the `<` direction correct! This will block until the file is sent.

----------------
 
Source: [Sharing files like a hacker](http://us2.campaign-archive1.com/?u=542a01cc849b6e2f33b5ada6f&id=e1d708af7e)

