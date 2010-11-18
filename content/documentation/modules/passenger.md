---
title: "Module: Passenger"
description: information regarding the git pusshuten passenger module to setup a full nginx or apache web server environment managed by phusion passenger
keywords: git, git pusshuten, ruby, command, phusion, passenger, nginx, apache, module, rails
---

You can add ([Phusion](http://www.modrails.com/)) Passenger to the modules in your configuration file, like so:

<% code do %>
pusshuten "My Application", :staging do
  modules do |m|
    m.add :passenger
  end
end
<% end %>

With Passenger enabled, it'll add a post deploy hook to the stack of deploy hooks that invokes `mkdir -p tmp; touch tmp/restart.txt` command after pushing your application to restart the Passenger instance.

Adding the Passenger module also enables the `passenger` CLI command.

List of commands
================

<% code do %>
heavenly passenger install for staging
heavenly passenger update for staging
heavenly passenger restart for production
<% end %>

install
-------

Installs Phusion Passenger with either Apache or NginX on your server.
It'll automatically install all dependencies for you as well.


update
-------

Updates Phusion Passenger and NginX or Apache web server if a new version is available.


restart
-------

Manually restarts the Passenger instance for the specified environment.


Requirements
============

You must have a version of Ruby and RubyGems installed. This is a simple procedure, just use the [RVM Module](/documentation/modules/rvm/)