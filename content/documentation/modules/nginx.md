---
title: "Module: NginX"
description: information regarding the git pusshuten nginx module to setup a full nginx web server environment
keywords: git, git pusshuten, ruby, command, nginx, web server
---

You can add NginX to the modules in your configuration file, like so:

<% code do %>
pusshuten "My Application", :staging do
  modules do |m|
    m.add :nginx
  end
end
<% end %>

With NginX enabled, you gain access to the `nginx` CLI command. With this, you will be able to invoke various operating on the NginX web server.

List of commands
================

<% code do %>
heavenly nginx install to staging
heavenly nginx setup staging environment
heavenly nginx download-configuration from staging
heavenly nginx upload-configuration to staging
heavenly nginx update-configuration for staging
heavenly nginx create-vhost for production
heavenly nginx delete-vhost from production
heavenly nginx upload-vhost to staging
heavenly nginx download-vhost from production
heavenly nginx start staging environment
heavenly nginx stop production environment
heavenly nginx restart production environment
heavenly nginx reload production environment
<% end %>


install
-------

Installs NginX (Standalone) on your server.  
**Ruby / Phusion Passenger users should install NginX through the Passenger module. Not with this command!**

setup
-----

Sets up a managable vhost environment. It will add a `/opt/nginx/conf/vhosts` directory to store the vhosts in. It will modify your `/opt/nginx/conf/nginx.conf` file to include all vhosts inside the vhosts directory. This invokes automatically after the web server is installed.


download-configuration
----------------------

Downloads the NginX configuration file to the `.gitpusshuten/nginx` directory so you can make quick local modifications to this file.


upload-configuration
----------------------

Uploads the NginX configuration file from your `.gitpusshuten/nginx` directory back to the server, overwriting the existing one.


update-configuration
--------------------

This will update your NginX configuration on the remote server. It will also create a backup of your current one in case something goes wrong. This is currently only useful when you are using [Phusion Passenger](/documentation/modules/passenger/) and would like to update the path to the current Passenger and/or Ruby version. This command will handle all of it for you.


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

Starts the NginX web server


stop
----

Stops the NginX web server


restart
-------

Restarts the NginX web server


reload
------

Reloads the NginX web server