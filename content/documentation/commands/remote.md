---
title: "Command: Remote"
description: information regarding the git pusshuten remote command
keywords: git, git pusshuten, ruby, command, remote
---

Performs a command in the remote server for the specified environment.

If you want to migrate your database for the staging environment, you'd run:

<% code do %>
heavenly remote command on staging 'rake db:migrate'
<% end %>

Or, if you wanted to bundle you gems for your production environment:

<% code do %>
heavenly remote command on production 'bundle install'
<% end %>

Or if you wanted to read out the contents of the production log of your app:

<% code do %>
heavenly remote command on production 'cat log/production.log'
<% end %>