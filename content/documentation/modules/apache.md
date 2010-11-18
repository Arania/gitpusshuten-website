---
title: "Module: Apache"
description: information regarding the git pusshuten apache module to setup a full apache web server environment
keywords: git, git pusshuten, ruby, command, apache, web server
---

You can add Apache to the modules in your configuration file, like so:

<% code do %>
pusshuten "My Application", :staging do
  modules do |m|
    m.add :apache
  end
end
<% end %>

With Apache enabled, you gain access to the `apache` CLI command. With this, you will be able to invoke various operating on the Apache web server.

List of commands
================

<% code do %>
heavenly apache install to staging
heavenly apache download-configuration from staging
heavenly apache upload-configuration to staging
heavenly apache update-configuration for staging
heavenly apache create-vhost for production
heavenly apache delete-vhost from production
heavenly apache upload-vhost to staging environment.
heavenly apache download-vhost from production
heavenly apache start staging environment
heavenly apache stop production environment
heavenly apache restart production environment
heavenly apache reload production environment
<% end %>


install
-------

Installs Apache2 (Standalone) on your server.  
**Ruby / Phusion Passenger users should install Apache2 through the Passenger module. Not with this command!**


download-configuration
----------------------

Downloads the Apache2 configuration file to the `.gitpusshuten/apache2` directory so you can make quick local modifications to this file.


upload-configuration
----------------------

Uploads the Apache2 configuration file from your `.gitpusshuten/apache2` directory back to the server, overwriting the existing one.


update-configuration
--------------------

This will update your Apache configuration on the remote server. It will also create a backup of your current one in case something goes wrong. This is currently only useful when you are using [Phusion Passenger](/documentation/modules/passenger/) and would like to update the path to the current Passenger and/or Ruby version. This command will handle all of it for you.


create-vhost
------------

Creates a (template) vhost locally for the specified environment which you can configure and immediately push to the desired environment.


delete-vhost
------------

Deletes a vhost from the remote server for the specified environment.


upload-vhost
------------

Uploads your local vhost to the server for the specified environment.


download-vhost
--------------

Downloads the remote vhost (if it exists) from the server for the specified environment.
This is particularly useful since you probably don't want to check the vhost into your repository and thus, can download, modify and upload it when needed.


start
-----

Starts the Apache web server


stop
----

Stops the Apache web server


restart
-------

Restarts the Apache web server


reload
------

Reloads the Apache web server