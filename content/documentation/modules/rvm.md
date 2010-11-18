---
title: "Module: RVM (Ruby Version Manager)"
description: information regarding the git pusshuten rvm (Ruby Version Manager) module to setup a managable Ruby environment
keywords: git, git pusshuten, ruby, rvm, ruby version manager, command, versions
---

You can add [RVM (Ruby Version Manager)](http://rvm.beginrescueend.com/) to the modules in your configuration file, like so:

<% code do %>
pusshuten "My Application", :staging do
  modules do |m|
    m.add :rvm
  end
end
<% end %>

The RVM module provides the `rvm` CLI command.

List of commands
================

<% code do %>
gitpusshuten rvm install on staging
gitpusshuten rvm update for staging
gitpusshuten rvm list for staging
gitpusshuten rvm install-ruby on production
gitpusshuten rvm uninstall-ruby from production
gitpusshuten rvm remove-ruby from production
gitpusshuten rvm set-default-ruby for production
<% end %>

install
-------

Installs RVM and an initial Ruby version. This is the "system wide" installation for RVM which enables multiple users to utilize the same installed rubies and gems. After the installation it'll set the specified Ruby as the system wide default Ruby so it can immediately be used for all your Ruby applications.


update
------

Updates RVM to either the **latest stable** or the **bleeding edge** version.


list
----

Displays a list of the currently installed Ruby versions.


install-ruby
------------

Install a new Ruby version using RVM to use for your Ruby applications.
You will be asked if you want to update your web servers configuration file to allow Passenger to work with the newly set default Ruby. If you say "yes", then it'll go ahead and reconfigure your web server's configuration file so you're ready to migrate from the current Ruby version to the next.


uninstall-ruby
--------------

Uninstalls the specified Ruby version from your server.


remove-ruby
-----------

Removes the specified Ruby version from your server (including the files).


set-default-ruby
----------------

Sets the default Ruby version for all Ruby applications on your server.
You will be asked if you want to update your web servers configuration file to allow Passenger to work with the newly set default Ruby. If you say "yes", then it'll go ahead and reconfigure your web server's configuration file so you're ready to migrate from the current Ruby version to the next.