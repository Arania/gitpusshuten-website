---
title: "Module: Active Record"
description: information regarding the git pusshuten active record module
keywords: git, git pusshuten, ruby, command, active record, rails
---

You can add Active Record to the modules in your configuration file, like so:

<% code do %>
pusshuten "My Application", :staging do
  modules do |m|
    m.add :active_record
  end
end
<% end %>

With Active Record enabled you gain access to a new deploy hook and a new CLI command. This module enables you to store a template `database.yml` for each environment on your server. This means you do not have to check your `database.yml` into your git repository.

To do this, simply run the following to generate the initial template for the desired environment:

<% code do %>
heavenly active_record create-configuration for staging
<% end %>

Now this creates a new file in `APP_ROOT/.gitpusshuten/active_record/staging.database.yml`. Modify this file to your needs and save it. Next, let's upload this to our remote server so that Git Pusshuten can pick it up later when we actually deploy our application (without the config/database.yml checked into our git repository).

<% code do %>
heavenly active_record upload-configuration to staging
<% end %>

And that's it! This will upload your new `staging.database.yml` to your remote server in `$HOME/modules/active_record/my_app.staging.database.yml`. You do not need to touch this at all. When deploying your application the next time, Git Pusshuten will invoke the Active Record deploy hook and ensure this `my_app.staging.database.yml` (when deploying the "staging" environment) is in place before doing any database creating or migrating.

These templates you generate locally should of course not be stored in your git repository as it would (almost) kill the entire purpose of this feature, so they are by default "git ignored".

Now if you later change computers, format your computer, or do a new clone from your remote development repository, you obviously won't have your `staging.database.yml` locally. If you want to make changes to your remote `my_app.staging.database.yml` (assuming you uploaded it previously) you can simply download, modify and re-upload it.

<% code do %>
heavenly active_record download-configuration from staging
<% end %>

Then edit it, and run

<% code do %>
heavenly active_record upload-configuration to staging
<% end %>

again.

It's as simple as that. So depending on what environment you use, you might want to use "staging" or "production". Each can have their own separate `*.database.yml` to ensure you are able to isolate the "staging" database from the "production" (and potentially other) database(s). 