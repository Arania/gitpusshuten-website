---
title: "Module: Bundler"
description: information regarding the git pusshuten bundler module
keywords: git, git pusshuten, ruby, command, bundler, gems, rails
---

You can add Bundler to the modules in your configuration file, like so:

<% code do %>
pusshuten "My Application", :staging do
  modules do |m|
    m.add :bundler
  end
end
<% end %>

With Bundler enabled, it'll add a post deploy hook to the stack of deploy hooks that invokes the `bundle install --without test development` command after pushing your application to ensure all gems are installed for your application.

Adding the Bundler module also enables the `bundler` CLI command. There is only one command: `bundle`.

<% code do %>
gitpusshuten bundler bundle for staging
<% end %>

And it'll install the gems for the application in the staging environment. In most cases this isn't needed since it'll invoke it after every `push` command to ensure they are installed. This command is particularly useful when you change ruby versions and don't have the gems installed any longer. Then you can just re-bundle the gems for your application without the need of a `push`.