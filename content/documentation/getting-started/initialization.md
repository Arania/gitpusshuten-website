---
title: Initializing Git Pusshuten for your application
---

To initialize Git Pusshuten with your application,
move into the root directory of your application and run the following command:

<% code do %>
gitpusshuten initialize
<% end %>

It'll create the following in your application's root folder:

<% code do %>
.gitpusshuten/
├── config.rb
├── hooks.rb
└── log
    └── gitpusshuten.log
<% end %>

So it'll have a hidden folder in your application's root directory. It'll have a config.rb and a hooks.rb file and a log directory which logs all actions you perform.

Everything, except `config.rb` and `hooks.rb` will be automatically added to your `.gitignore` file. If the file does not exist, it'll be added upon initialization. This includes the log file as well as anything else that might be created within `app_root/.gitpusshuten/some_dir`.

Alias
-----

It's worth mentioning that there is an alias available for the long `gitpusshuten` command. Instead of typing `gitpusshuten` every time, you can simply use `ten` instead. For example:

<% code do %>
ten initialize
<% end %>