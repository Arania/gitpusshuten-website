---
title: "Command: Initialize"
---

Initializes Git Pusshuten with your working directory. You want to run this command from within the root of your application.
This will create a few files.

<% code do %>
.gitpusshuten/
├── config.rb
├── hooks.rb
└── log
    └── gitpusshuten.log
<% end %>

It will also add this line to your `.gitignore` file:

<% code do %>
.gitpusshuten/**/*
<% end %>

to ignore all files except for the `config.rb` and `hooks.rb`.

Here you can find more information on the [config.rb](/documentation/getting-started/configuration/)
and the [hooks.rb](/documentation/getting-started/deployment-hooks/)