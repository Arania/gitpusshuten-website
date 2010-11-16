---
title: "Command: Remote"
---

Performs a command in the remote server for the specified environment.

If you want to migrate your database for the staging environment, you'd run:

<% code do %>
gitpusshuten remote command on staging 'rake db:migrate'
<% end %>

Or, if you wanted to bundle you gems for your production environment:

<% code do %>
gitpusshuten remote command on production 'bundle install'
<% end %>

Or if you wanted to read out the contents of the production log of your app:

<% code do %>
gitpusshuten remote command on production 'cat log/production.log'
<% end %>