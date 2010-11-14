--- 
title: About Git Pusshuten (プッシュ点ー)
---

What is Git Pusshuten?
================================

Git Pusshuten is a Git-based deployment [Ruby Gem](http://rubygems.org/gems/gitpusshuten).


What does it do?
================

Nothing, and everything! Git Pusshuten, at it's core, is an easy to use CLI utility that allows you to use Git to push your applications to your remote server for multiple environments (e.g. staging, production). It provides you with pre and post deploy hooks for the push process. Git Pusshuten also helps you setup a proper "Git Pusshuten Ready" environment on your server with a single command.


Why Git Pusshuten?
==================

I am fully aware there are other open source Git and non-Git based deployment solutions like "Capistrano", "Vlad the Deployer", "Gploy", "Git Deploy", "Screwcap", "Deployer", and the list goes on.

Now, I wanted a tool that would handle deployment. And at it's core, that is what it does, and it does it for multiple environments. Another thing I miss in other git-based deployment solutions is the ability to push, __not only a branch__, but also by __tag__ or __ref__. We're using __Git__, why not use more of what it has to offer?

Here is how you would push your application to __staging__ or __production__ by either __branch__, __tag__ or __ref__.

<% code do %>
  gitpusshuten push branch develop to staging
  gitpusshuten push tag 1.3.2 to production
  gitpusshuten push ref f7bcec6a23bcb9c7695beb060c11d3b7b3e80702 to staging
<% end %>

Next, I wanted a way to actually provision/manage my environment without actually manually going into it every single time. When I deploy a new application, I want to have my application up and running as fast as possible.

Enter [Git Pusshuten](http://github.com/meskyanichi/gitpusshuten). Read about __modularity__ below.


Who is it for?
==============

Anyone that wants to deploy an application to a remote server. I'd say it's primarily for __Rubyists__, but it can __easily__ be used to deploy non-Ruby applications, like Python, PHP or plain HTML.


Modularity
==========

Aside of the core, which handles deployment, deploy hooks, user setup, and such, Git Pusshuten is really what it is because of it's modular architecture. A module can consist of two things: a series of "commands" and a series of "hooks". This is exactly like the core of Git Pusshuten, except that we call them __modules__. I can write modules, and so can __you__!

So what it basically comes down to is that a __module__ can extend the core in any direction. The core is abstract and can be used for any application, while a module is particularly meant to actually define __your__ environment and, based on that, provide you with commands and hooks to get the job done for __your__ application in __your__ environment.

Let me show you a simple snippet you can add to your configuration file.

__For this example let's assume we have the following application specifications:__

* [Ruby on Rails](http://rubyonrails.com/) 3 application
* [Bundler](http://gembundler.com/)
* Active Record ORM

__As for the deployment environment, we want to use:__

* Ruby (Managed with RVM, [Ruby Version Manager](http://rvm.beginrescueend.com/))
* [NginX Webserver](http://wiki.nginx.org/Main)
* [Phusion Passenger](http://www.modrails.com/) (NginX Module)

Let's tell Git Pusshuten we're using this by defining the modules in the configuration file.

<% code do %>
  # inside app_root/.gitpusshuten/config.rb
  modules |m|
    m.add :bundler
    m.add :active_record
    m.add :passenger
    m.add :nginx
    m.add :rvm
  end
<% end %>

That's it. You are just minutes from now your application will be up and running on a __fresh Ubuntu installation__ with the above mentioned specifications, and you've never even had to manually SSH into your server either.

_"But aside of the above mentioned modules, I'd like to change my SSH port, maybe lock it down with a firewall, etc. etc."_

That's nice. Fork the project, write a module and share it on [GitHub](http://github.com/) with the rest of the community. : )

Now, you might be saying: _"Well, this tool isn't just about __deployment__, it also provisions/configures my environment."_

This is correct, and I'm using the term __modules__ as an excuse. It's not the __core__ functionality. The __core__ functionality is deployment. The environment specific functionality are the __modules__, which, by default, are turned __OFF__.


Requirements
============

That you use [Git](http://git-scm.com/) as your SCM tool for your project, and that you have _basic_ knowledge of the [Ruby](http://ruby-lang.org/) programming language. It doesn't really require any Ruby programming, the only Ruby code are the 2 small configuration files, which come in a simple template. So even without Ruby knowledge you should be able to properly adjust it.


Compatibility
=============

I have successfully setup Git Pusshuten on Ubuntu 10.10, 10.04, 9.10, 9.04 and 8.10.
I use Ubuntu, so I wrote it to work with Ubuntu. It might work for your operating system but I cannot guarantee it.
If it doesn't work with your operating system, you can of course fork the project and build in the compatibility yourself.


Note
====

The project is still very young so there aren't a lot of modules to pick from. One of the reasons I released it is so I could also get feedback from the community. Another reason I released it is so that people can contribute to the project to make Git Pusshuten better.


Documentation and Guides
========================

Check out the [Guides](/guides/) and [Documentation](/documentation/) for more info.
