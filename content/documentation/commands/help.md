---
title: "Command: Help"
---

Bring up the main help screen by running:

<% code do %>
gitpusshuten help
<% end %>

which looks something like this:

<% code do %>
Git Pusshu Ten
     プッシュ点

[Alias]

  ten

[Commands]

  delete      Deletes the application of the specified environment.
  help        Displays the command list, or the help screen for a specific command.
  initialize  Initializes Git Pusshu Ten (プッシュ点) with the working directory.
  push        Pushes a branch, tag or ref to the specified environment.
  remote      Performs a command on the remote server for the specified environment from the application root.
  setup       Setups up various things for you, based on the .gitpusshuten/config.rb file.
  user        Interacts with users, based on the <app_root>/.gitpusshuten/config.rb file.
  version     Displays the current version of Git Pusshu Ten (プッシュ点).

[Command Specific Help]

  gitpusshuten help <command>

For more information, visit: http://gitpusshuten.com/
<% end %>

You can also invoke the help command on an individual command to get information about that particular command:

<% code do %>
gitpusshuten help user
<% end %>

displays something like this:

<% code do %>
Git Pusshu Ten
     プッシュ点

[Command]

  user

[Description]

  Interacts with users, based on the <app_root>/.gitpusshuten/config.rb file.

[Usage]

  user <command> (to|for|from|on) <environment>

[Examples]

  gitpusshuten user add to production                # Sets up the user on the remote server for production.
  gitpusshuten user reconfigure for production       # Reconfigures the user without removing applications.
  gitpusshuten user remove from production           # Removes the user and all it's applications.
  gitpusshuten user install-ssh-key on staging       # Installs your ssh key on the server for the user.
  gitpusshuten user install-root-ssh-key on staging  # Installs your ssh key on the server for the root user.

For a list of all commands: gitpusshuten help
For more information, visit: http://gitpusshuten.com/
<% end %>

