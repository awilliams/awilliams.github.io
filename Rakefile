desc 'create new post. args: title, description (optional)'
task :new, :title, :description do |t, args|
  title = args.title or raise ArgumentError, 'Title must be provided'
  slug = title.gsub(' ','-').downcase

  filename = "#{Time.new.strftime('%Y-%m-%d')}-#{slug}.markdown"
  path = File.join('_posts', filename)
  raise ArgumentError, "#{path} already exists" if File.exists?(path)

  post = %(---
layout: post
title: "#{title}"
tagline:
description: "#{args.description}"
category: articles
tags: []
---


)
  File.write(path, post)
  puts "Created: #{path}"

  system "vim +#{post.lines.count + 1} #{path}"
end