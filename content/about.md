---
title: About Git Pusshuten (プッシュ天)
description: "Git Pusshuten, a Git based deployment Ruby Gem that simplifies deployment."
keywords: ruby, git, push, rails, deploy, deployment, ubuntu
---

What is Git Pusshuten and what does it do?
==========================================

It is a Git-based application deployment tool that allows you to define your environment by utilizing modules and provision your server with basic deployment needs.

**Your first impression:** *"What's up with the name?"*

Git = Git  
Pusshu = Push ( プッシュ )  
Ten = Heaven ( 天 )

I have seen "git deploy", "gploy", "deployer" and similar names.  
This is my attempt at trying to be unique. But, in the end, it's just a name. Love it or hate it.  
Regardless of the name, I do hope it is useful to you if you're looking for a new approach at (web) application deployments!  

**Check out the video below!**

<iframe src="http://player.vimeo.com/video/16976280" width="750" height="425" frameborder="0"></iframe>

**In this screencast I show you how to set up a server with the following with Git Pusshuten:**

* RVM (Ruby Version Manager)
* Ruby 1.9.2
* Phusion Passenger
* NginX web server
* MySQL database
* UNIX deployment user for Git Pusshuten

And deploy a standard "you are riding the rails" application to it.

*Note that some installations such as the Ruby 1.9.2, Phusion Passenger and NginX installation have been fast-forwarded in this screencast. They may take several minutes, depending on your server specifications.*

[Check out this guide](/guides/setting-up-a-full-ruby-on-rails-environment/) where I go more into detail about the above screencast.


Read on if you want to know more about Git Pusshuten
====================================================

Please bear with me as I attempt to explain what Git Pusshuten is all about. : )

The Core
--------

This is basically the bare minimum you get when you haven't enabled any modules. You will get the following:

* The ability to push **any** local **branch**, **tag** or **ref** to **any** remote **environment** (staging, production, beta, etc)
* The ability to set up a UNIX user with a single command to be "Git Pusshuten Deployment Ready"
* The ability to add "pre" and "post" remote deploy hooks after pushing your application

This introduces an interesting workflow, especially (but absolutely not required) when using the [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/) branching model.

Now, with Git Pusshuten, you can easily push your application by **branch**, **tag** or **ref**. This means you won't be limited to the standard `git push origin production`. Here is an example of how you would push by branch, tag or ref:

<% code do %>
  # Pushes develop branch to staging environment so for example you or your client can test it
  heavenly push branch develop to staging
  
  # Pushes the master branch to production, which releases a new version of your application
  heavenly push branch master to production
  
  # Pushes version "1.5.2" (git tag 1.5.2) of your application to production
  heavenly push tag 1.5.2 to production
  
  # Pushes your application by a "git ref" to the staging environment
  heavenly push ref 1466496e89857fd2d9dbdefb13d86d994d1b319a to staging
<% end %>


Deployment Hooks
----------------

Hooks are small pieces of shell scripts that are invoked "pre" or "post" deployment. For example, if you are running Phusion Passenger and want to restart the Passenger instance on your server, you could add a simple hook like so:

<% code do %>
  perform_on :staging, :production do
    post "Restart Passenger Instance" do
      run "touch tmp/restart.txt"
    end
  end
<% end %>


Modules
-------

This is where Git Pusshuten actually **defines** your environment and starts to get even more interesting.
Modules are essentially "add-ons" which you can cherry pick for your configuration. By default, all modules are disabled. A module may consist of both a new CLI command and hooks. For example, if I add this to my configuration file:

<% code do %>
  modules do |m|
    m.add :passenger
  end
<% end %>

It would add the above deployment hook example I just showed you, without you having to manually define the hook in the hooks file. Additionally it also provides you with a `passenger` CLI command. Using this CLI command you can do various things like manually restart the Passenger instance ( `heavenly passenger restart staging environment` ) and you can even tell it to install Phusion Passenger with either NginX or Apache2 on your server by running `heavenly passenger install to staging environment`. It will then go ahead and install all NginX/Passenger dependency packages and install/configure NginX to work with Git Pusshuten for your application deployments. So as you can see, modules can be very powerful as they can set up your entire environment without you ever having to manually SSH into the server.

Let me show you a combination of modules I recently used to deploy one of my application with:

<% code do %>
  modules do |m|
    m.add :bundler
    m.add :active_record
    m.add :passenger
    m.add :nginx
    m.add :rvm
    m.add :mysql
  end
<% end %>

With the above modules in place, it took me only about 10-15 minutes to go from a **new** Ubuntu 10.04 installation, to a fully configured and manageable Ruby on Rails, NginX, Phusion Passenger, RVM and MySQL environment. I never even SSH'd into my server to further configure my vhosts or nginx.conf file, this is all managed by Git Pusshuten. If I wanted to migrate from Ruby 1.8.7 to 1.9.2 tomorrow, I can do this with Git Pusshuten locally with a single command, again, without manually SSH'ing in to run commands and configure files. I can also update Passenger when a new version releases, all thanks the modules above.

This (static) website ( http://gitpusshuten.com/ ) has been deployed with just these modules:

<% code do %>
  modules do |m|
    m.add :nginx
    m.add :nanoc
  end
<% end %>

Since I am using the [Nanoc](http://nanoc.stoneship.org/) Ruby-based static site generator, I wrote a simple Nanoc module which simply adds a little "post" deploy hook. It took me 30 seconds to write. I use it in combination with the NginX module so I can manage the NginX web server's vhosts through Git Pusshuten.

At this time there aren't a lot of modules, but the most common ones I use are there. Writing these modules is quite easy as well, so anyone can add more, which is one of the important aspects of this project. I actually want to release Git Pusshuten **v0.0.1** and see if the community is interested in using and further improving this project, by adding a lot more modules, improving existing ones, improving the core, and asking me what I was smoking while coding some parts of the system and provide feedback. **; )**


SSH
---

There are of course times when you want to SSH in to your server. Git Pusshuten isn't about configuring 100% of your server, just the majority of the deployment environment, which in some cases, is enough! But, when the need arises, and no module exists, and you don't feel like writing one yourself, then for convenience Git Pusshuten provides you two CLI commands that help you log in through ssh as the deployment user, or the root user.

<% code do %>
  $(heavenly user login to staging)
  $(heavenly user login-root to production)
<% end %>

And you can, as always, do whatever you want. Update/upgrade your packages. Install other utilities, and such. I believe there is a place for a module that contains the "common" installations, such as **imagemagick**, **sphinx**, **memcached**. Even though you can always ssh into your server to just run the one-line command, it's still nice to have a module that has 'common' provisioning. We could have something like:

<% code do %>
  heavenly provision memcached for staging
  heavenly provision sphinx for staging
  heavenly provision imagemagick for production
  # etc. etc. etc.
<% end %>

Things that are common for web applications these days.


So, who exactly is it for?
==========================

Because Git Pusshuten attempts to be a modular deployment tool, you could say it is for **everyone** and **any language**.
However, I am sure the majority of the user-base will be **Rubyists**.


Community == Knowledge # => true
--------------------------------

My knowledge is limited, which is why I love open source, especially in the Ruby community. People can and usually will share their knowledge and provide feedback to help and improve projects. So if you have any questions, comments, suggestions, want to help, fork and what not, hop on over to the [GitHub repository](https://github.com/meskyanichi/gitpusshuten)!


Requirements
============

That you use [Git](http://git-scm.com/) as your SCM tool for your project, and that you have _basic_ knowledge of the [Ruby](http://ruby-lang.org/) programming language. It doesn't _really_ require any Ruby programming, the only Ruby code are the config.rb and hooks.rb files, which come in a simple templates. So even without Ruby knowledge you should be able to properly configure it.


Compatibility
=============

I have successfully setup Git Pusshuten on Ubuntu 10.10, 10.04, 9.10, 9.04, 8.10 and 8.04.
I use Ubuntu, so I wrote it to work with Ubuntu. It might work for other operating systems but I cannot guarantee it. If it doesn't work with your operating system, you can of course fork the project and build in the compatibility yourself if necessary.


Note
====

The project is still very young so there aren't a lot of modules to pick from. There is a lot of room for improvement for the current code base, I am sure. But, for me, and maybe for you, this works. I believe it is a good starting point. If you're missing modules, feel free to request them, or fork the project and add them yourself.


Documentation, Guides and the Repository
========================================

Check out the [Guides](/guides/) and [Documentation](/documentation/) for more info. The project's repository is hosted at [GitHub](https://github.com/meskyanichi/gitpusshuten).
