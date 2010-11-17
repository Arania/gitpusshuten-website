--- 
title: About Git Pusshuten (プッシュ点ー)
---

What is Git Pusshuten?
======================

Git Pusshuten is a Git-based deployment [Ruby Gem](http://rubygems.org/gems/gitpusshuten).
Not only can it push your applications by **branch**, **tag** or **ref** to multiple environments, which is what it does at it's core, it also has a modular architecture to enable you to define **YOUR** environment using, what I call **modules**, and act based on that.

I feel that I am not very good at giving clear and concise explanations, so I have prepared a little video to actually __show__ you what it __can__ do.

[video here]


What does it do?
================

Git Pusshuten, at it's core, is an easy to use CLI utility that allows you to use Git to push your applications to your remote server for multiple environments (e.g. staging, production). It provides you with "pre" and "post" deploy hooks to go with the push process. Git Pusshuten also helps you setup a proper "Git Pusshuten Ready" environment on your server with a single command.

By defining the correct modules, you could have, for example, a full Ruby on Rails environment set up on a **new** Ubuntu installation within about 10-15 minutes. Refer to [this guide](/guides/setting-up-a-full-ruby-on-rails-environment/) if you want to try that or check out the video above!

Why Git Pusshuten?
==================

I am fully aware there are other open source Git and non-Git based deployment solutions like "Capistrano", "Vlad the Deployer", "Gploy", "Git Deploy", "Screwcap", "Deployer", and the list goes on.

What sets Git Pusshuten apart of (as far as I know) everything else?

* The ability easily to push to multiple environments
* The ability to push based on **branch**, **tag** or **ref**.
* The ability to have a **new Ubuntu** server provisioned and "deploy ready" in a few minutes
* The ability to be done configuring within 10 seconds
* The ability to be modular and extensible, a way to actually **define** my environment, even to the extent that it doesn't even have to be a Ruby app.

Yes, you've guessed it. Git Pusshuten isn't just about **application deployment**, it is also about **server provisioning for "Git Pusshuten" application deployment**. But again, NOT at it's core. At it's core it only understands Git, and nothing else. When you define modules, it learns about your environment.


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
* MySQL

Let's tell Git Pusshuten we're using this by defining the modules in the configuration file.

<% code do %>
  # inside app_root/.gitpusshuten/config.rb
  modules |m|
    m.add :bundler
    m.add :active_record
    m.add :passenger
    m.add :nginx
    m.add :rvm
    m.add :mysql
  end
<% end %>

That's it. You are just minutes away from having your application up and running on a __new Ubuntu installation__ with the above mentioned specifications, and you've never even had to manually SSH into your server either.

_"But I would like to use Apache2 instead of NginX"_

Sure, just change `m.add :nginx` into `m.add :apache`. Now, obviously there aren't a lot of modules to pick from right now. I have added most of what I need. If you want more then you can request it on [GitHub](http://github.com/), or better yet, fork and write it yourself (it's really easy) and ask me to merge it into the main project.

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
