---
title: "Module: MySQL"
description: information regarding the git pusshuten mysql module to setup a mysql server on your server
keywords: git, git pusshuten, ruby, command, mysql
---

You can add MySQL to the modules in your configuration file, like so:

<% code do %>
pusshuten "My Application", :staging do
  modules do |m|
    m.add :mysql
  end
end
<% end %>

With MySQL enabled, you gain access to the `mysql` CLI command. With this, you will be able to invoke various operations on the remote server.

List of commands
================

<% code do %>
heavenly mysql install on staging
heavenly mysql uninstall from staging
heavenly mysql add-user to staging
heavenly mysql remove-user from staging
heavenly mysql change-root-password on staging
<% end %>


install
-------

To install MySQL on your server. You will be prompted to choose a MySQL root password.


uninstall
---------

To uninstall the MySQL installation. You will be prompted for your root password.


add-user
--------

Adds a database user to the MySQL database which you can use for your application to connect to.


remove-user
-----------

Removes a user from the MySQL database.


change-root-password
--------------------

Allows you to change the root password of your MySQL database on the remote server.