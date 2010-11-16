---
title: "Module: Nanoc"
---

You can add [Nanoc](http://nanoc.stoneship.org/) to the modules in your configuration file, like so:

<% code do %>
pusshuten "My Application", :staging do
  modules do |m|
    m.add :nanoc
  end
end
<% end %>

With Nanoc enabled, it'll add a **post deployment hook** to the to the stack.
This hook does the following on the remote server after the push:

* remove the `app_root/output` folder
* remove the `app_root/public` folder
* run `nanoc compile` which compiles your website to `app_root/output`
* renames the `app_root/output` to `app_root/public`

So your web server's configuration file just needs to point to (what it always points to and is the default configuration when you create a new vhost) `/path/to/app_root/public` and you're set!