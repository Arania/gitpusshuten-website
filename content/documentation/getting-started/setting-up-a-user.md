---
title: Setting up a deployment user
---

Once you've finished configuring your `.gitpusshuten/config.rb` file, Git Pusshuten can create and configure a new user on your server, based on this configuration. To do this, simply run the following command.

<% code do %>
heavenly user add to staging
<% end %>

This will do a couple of things, including, of course, creating the user, setting up ssh key if applicable, configuring the .bashrc / .gemrc files, adding the user to the rvm group if rvm is installed, configure Git for deployment with this user. And such.