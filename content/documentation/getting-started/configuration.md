---
title: Configuring your configuration file
---

Next, let's take a look at the configuration file.

<% code do %>
pusshuten 'My Application', :staging, :production do
  authorize do |a|
    a.user       = 'gitpusshuten'
    # a.password   = 'my-password'
    # a.passphrase = 'my-ssh-passphrase'
    a.ip         = '123.45.678.90'
    a.port       = '22'
  end

  applications do |a|
    a.path = '/var/applications/'
  end
end
<% end %>

This is basically all you need to setup both a **staging** as well as a **production** environment. These variables should be quite straightforward. By default, the **password** and **passphrase** are commented out. Why? Because It's safer to use a SSH key rather than a password. But, you can choose whichever you prefer! Also, when using an SSH key with a passphrase, you can specify the passphrase for Git Pusshuten when trying to interact with the server.

So let's talk about the **applications** block for a second.

<% code do %>
applications do |a|
  a.path = '/var/applications/'
end
<% end %>

This block basically allows you to define the location to where your applications will be stored. Now, assume we have a **staging** environment and a **production** environment. When you push both environments to the server you will get two different directories, namely:

<% code do %>
/var/applications/my_application.staging
/var/applications/my_application.production
<% end %>

So you are now able to push anything that is unstable, still in development, or just to preview to a client, to the *staging environment*. Once you confirm that the particular version of your application is ready for production, you push it to production.

You can of course nest multiple different applications in the same **/var/applications/** directory. The application's deployment directory is based on the combination of the "application name" and the "environment". These are defined here:

<% code do %>
pusshuten 'My Application', :staging, :production do
<% end %>

Here "My Application" is the application name, it will be somewhat "sanitized" to "my_application". Then the rest of the arguments are basically to define the environments. ":staging" and ":production" use the same configuration in this case. The only difference being the location to where are pushed.

Additionally you can share the same configuration between both environments, and then overwrite or append configuration by defining a new configuration block, like so:

<% code do %>
pusshuten 'My Application', :staging, :production do
  authorize do |a|
    a.user   = 'gitpusshuten'
    a.ip     = '123.45.678.90'
    a.port   = '22'
  end
end

pusshuten 'My Application', :production do
  authorize do |a|
    a.ip     = '098.76.543.21'
    a.port   = '44'
  end
end
<% end %>

In the above example both the ":staging" and ":production" environment share the same user, but the ":production" environment overwrites the "ip" and "port" to point to a different server. So in this case, the staging and production environments are run on separate servers.

So that's basically all there is to configuring Git Pusshuten's __core__!

If you want to extend this functionality with more **environment specific** configuration, this is easily done by adding modules.
So assume you want to use **Active Record, Bundler, RVM, Phusion Passenger and NginX** you would simply define it like so:

<% code do %>
pusshuten 'My Application', :staging, :production do
  authorize do |a|
    # authorize config
  end

  applications do |a|
    # applications config
  end

  modules do |m|
    m.add :bundler
    m.add :active_record
    m.add :passenger
    m.add :nginx
    m.add :rvm
  end
end
<% end %>

A module can enable two things:

* New CLI Commands
* New Deployment Hooks

For example, when you add the **Bundler** module, you gain access to a new CLI command, and at the same time, it'll add a deployment hook that'll bundle the gems post-deployment for your application. The deploy hook will first check the remote environment to see if the Bundler gem is installed, if not it'll install it and then proceed to run the `bundle install` command. The command that has been added to the CLI in this case will allow you to manually run the "bundle install" command on demand, without the need to deploy your application. The syntax of the command looks like this:

<% code do %>
gitpusshuten bundler bundle for staging # or production
<% end %>

The **ActiveRecord** module does not add any CLI commands but it does perform the `rake db:migrate` deploy hook for you when you deploy your application to ensure the database is up to date.

The Passenger, NginX and RVM commands will help you provision and manage your remote environment.

* __RVM__ helps you install/manage/change Ruby versions for your apps
* __Passenger__ helps you install a webserver (NginX or Apache)
* __NginX__ helps you config the NginX config file for easy "vhost" management

Read more about modules [here](/documentation/modules/).