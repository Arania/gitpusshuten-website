---
title: Setting up a deployment user
---

Once you've finished configuring your configuration file, Git Pusshuten will create and configure a new user on your server. To do this, simply run the following command:

<% code do %>
gitpusshuten user add to staging
<% end %>

This will take a few as it connects to the server, installs your ssh key, configures various files on the server, and such. Well, that's it!