---
title: "Setting up a full Ruby on Rails environment on Ubuntu 10.04 with NginX, Phussion Passenger, MySQL, RVM (Ruby Version Manager) in minutes with Git Pusshuten."
description: "Setting up a full Ruby on Rails environment on Ubuntu 10.04 with NginX, Phusion Passenger and MySQL."
keywords: git, ruby, rails, deployment, nginx, passenger, ubuntu, mysql
---

This guide will demonstrate how to setup a full Ruby on Rails environment on a new Ubuntu 10.04 server in 15 minutes. We will be provisioning it with the following utilities:

* NginX
* Phusion Passenger
* RVM (Ruby Version Manager)
* Ruby 1.9.2
* MySQL

And we will be done in a few minutes.

First of all, install the Git Pusshuten gem.

<% code do %>
gem install gitpusshuten
<% end %>

Next, move into the root of your Ruby on Rails application and initialize Git Pusshuten.

<% code do %>
cd /path/to/Rails.root
heavenly initialize
<% end %>

Next, open the `Rails.root/.gitpusshuten/config.rb` and configure it.

<% code do %>
pusshuten 'My Application', :staging, :production do
  authorize do |a|
    a.user       = 'gitpusshuten'
    a.ip         = '123.45.678.90'
    a.port       = '22'
  end

  applications do |a|
    a.path = '/var/applications/'
  end

  modules do |m|
    m.add :bundler
    m.add :active_record
    m.add :passenger
    m.add :nginx
    m.add :rvm
    m.add :mysql
  end
end
<% end %>

OK! So now we're practically finished with the complete configuration for Git Pusshuten.

The first thing I like to do is to install my ssh key on to the server (under root) so I don't get prompted for my root password every time.

<% code do %>
heavenly user install-root-ssh-key to staging
<% end %>

You will be asked to provide your root password, do so and your ssh key will be installed. Done.

Now, let's start installing software! We will start with RVM (Ruby Version Manager) so we can install Ruby to our system.

<% code do %>
heavenly rvm install to staging
<% end %>

You will be prompted to select the initial Ruby version you Git Pusshuten want to install after it finishes installing RVM. I will go with 1.9.2 since that's what we **should** be using today.

Once it has finished installing RVM and Ruby 1.9.2, we will go ahead and install Phusion Passenger.

<% code do %>
heavenly passenger install to staging
<% end %>

You will be prompted to with a choice of either the NginX or the Apache2 web server. We will go with NginX. So, select NginX and wait for it to finish. Once it finishes, it will go ahead and configure your NginX configuration file for your so you get an easy way of managing your vhosts without having to manually ssh into the server every time. Also, it will create an NginX vhost on your local machine in `Rails.root/.gitpusshuten/nginx/staging.vhost`. We will get back to shortly.

Next, let us setup our initial user **gitpusshuten**, as specified in our `Rails.root/.gitpusshuten/config.rb` file.

<% code do %>
heavenly user add to staging
<% end %>

It will ask you if you are sure you want to setup a deployment user named **gitpusshuten** to the staging environment. Say "yes" and you will be prompted for a password for this user (unless you specified on in the configuration file, then it'll use that one). Once that's done it'll start creating the user on your server and properly configure it to work with Git, RVM and such.

So the next step is to set up our MySQL server.

<% code do %>
heavenly mysql install to staging
<% end %>

You will be prompted to fill in a root password for the MySQL root user. Choose one and it'll start installing MySQL on your server. Once this is done, let's go ahead and add a new MySQL user to the MySQL database. This again, will be the user we specified in the `Rails.root/.gitpusshuten/config.rb` file, which again, is **gitpusshuten**.

<% code do %>
heavenly mysql add-user to staging
<% end %>

You will first be prompted for your MySQL root password. Once that's done, you'll be prompted for a password for this new user. Once you fill in the desired password, it'll go ahead and add the user to the MySQL database. With that, our Ubuntu 10.04 server has been provisioned.

That was simple, wasn't it? Just a few commands and you're up and running. We aren't finished just yet of course, so let's wrap it up.

Let's make the needed changes to our application. For one, when using the **Active Record** module, which we are, it's a good idea to make separate **database.yml** files in `Rails.root/config`. One for each environment. Now, this step is only a good idea if:

* 2 or more environments run on the same server (IP)
* You are not planning on sharing the same database between multiple environments

So, in our case we use the same ip for both the **staging** and the **production** environment, as specified in the configuration file. So we will add these 2 files:

* database.yml.staging
* database.yml.production

Inside the database.yml.staging we'd have:

<% code do %>
production:
  adapter: mysql2 # <--- Notice we are using the MySQL 2 gem.
  encoding: utf8
  reconnect: false
  database: my_application_staging
  pool: 5
  username: gitpusshuten
  password: gitpusshutens_password
  host: localhost
<% end %>

Inside the database.yml.production

<% code do %>
production:
  adapter: mysql2 # <--- Notice we are using the MySQL 2 gem.
  encoding: utf8
  reconnect: false
  database: my_application_production
  pool: 5
  username: gitpusshuten
  password: gitpusshutens_password
  host: localhost
<% end %>

The only difference is the database name, which is based on the environment we're working with. So, when using the **Active Record** module, it adds a deploy hook that will overwrite the default **database.yml** with one of the above, depending on what environment we're deploying. So, let's move on to the deployment!

Let's assume we're working on the **master** branch and we want to deploy this to the **staging** environment. This is simple, just run this:

<% code do %>
heavenly push branch master to staging
<% end %>

Done. After the push, it'll invoke a couple of deploy hooks, which have been added by the modules we included in our configuration file. Let's go over them briefly (in order).


bundler
-------

Bundler will simply start bundling the gems for your Ruby on Rails application. We all know how that works.


active_record
-------------

We are pushing to our **staging** environment, so Active Record will first look for the `Rails.root/config/database.yml.staging` file to see if it exists. If it does, it'll simply overwrite the `Rails.root/config/database.yml` with `Rails.root/config/database.yml.staging` so we're using the **staging** database yaml, which connects with **my_application_staging** database.

Next, Active Record will then run `rake db:create` to ensure the database exists, followed by `rake db:migrate` to migrate your production database.


passenger
---------

Passenger will simply restart the Passenger instance for your Ruby on Rails application by invoking the `touch tmp/restart.txt` command.


That's it. Your application should be up and running now, except that we cannot access it yet. Remember the NginX vhost template that was created in `Rails.root/.gitpusshuten/nginx/staging.vhost`? Let's quickly edit and activate it.

This is the vhost template that has been generated by Git Pusshuten.

<% code do %>
server {
  listen 80;
  server_name mydomain.com www.mydomain.com;
  root /var/applications/revolutionary_project.staging/public;
  # passenger_enabled on; # For Phusion Passenger users
}
<% end %>

And this is what we want it to look like:

<% code do %>
server {
  listen 80;
  server_name mydomain.com www.mydomain.com;
  root /var/applications/revolutionary_project.staging/public;
  passenger_enabled on;
}
<% end %>

I basically just uncommented the `passenger_enabled on;` line. Of course, depending on your domain name, fill in the appropriate one above. Once done, save the file and run the following:

<% code do %>
heavenly nginx upload-vhost to staging
<% end %>

This will upload your vhost in the proper NginX vhosts directory Git Pusshuten already set up for us. It'll then restart the NginX web server and there you go! You're up and running on **Ubuntu 10.04** running **NginX**, **Phusion Passenger**, **RVM**, **MySQL** in a managed and Git-based deployment environment.


Conclusion
==========

Now, if I wouldn't have explained anything to you guys, this is what you'd end up with for this guide:

<% code do %>
gem install heavenly
heavenly initialize
heavenly user install-root-ssh-key to staging
heavenly rvm install to staging
heavenly passenger install to staging
heavenly user add to staging
heavenly mysql install to staging
heavenly mysql add-user to staging
heavenly push branch master to staging
heavenly nginx upload-vhost to staging
<% end %>

**And we configured the following:**

* Git Pusshuten's config.rb file
* NginX's vhost file

That's it. From a **new** Ubuntu 10.04 installation, to a deployed Ruby on Rails application in minutes.
(I did it in about 10-15 minutes.) And that was mainly waiting on installations to finish. Also, the time it takes to install everything of course depends on your server specs. I was running a small 256meg vps.

You can try this out on a "test" server if you have it. Otherwise boot up a local VM and try it there.

In any case, hope this helps people to deploy and maintain their Ruby on Rails application.