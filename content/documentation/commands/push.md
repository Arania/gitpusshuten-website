---
title: "Command: Push"
description: information regarding the git pusshuten push command to push your applications to production
keywords: git, git pusshuten, ruby, command, push
---

Pushes your application to the specified environment.
You can push your application by **branch**, **tag** or **ref**.

If you want to push your **develop** branch to the remote **staging** environment, you would run this command:

<% code do %>
heavenly push branch develop to staging
<% end %>

If you wanted to push the master branch to the production environment, you would run this command:

<% code do %>
heavenly push branch master to production
<% end %>

If you wanted to release version 1.0.3 of your application (which you tagged 1.0.3 with `git tag`) to production, then you can run this:

<% code do %>
heavenly push tag 1.0.3 to production
<% end %>

And finally, you have the option to push your application to the remote environment by using the __ref__ like so:

<% code do %>
heavenly push ref 2dbec02aa0b8604b8512e2fcbb8aac582c7f6a73 to production
<% end %>