---
title: "Command: User"
description: information regarding the git pusshuten user command to set up unix users on your server
keywords: git, git pusshuten, ruby, command, user
---

User has a bunch of commands at it's disposal.

<% code do %>
heavenly user add to production
heavenly user reconfigure for production
heavenly user remove from production
heavenly user install-ssh-key to staging
heavenly user install-root-ssh-key to staging
$(heavenly user login to staging)
$(heavenly user login-root to production)
<% end %>

add
---

Adds a user to the specified environment. It uploads you SSH key (if you have one) and then further configures the user.


reconfigure
-----------

Reconfigures the user, keeping all applications, and the user itself in tact. All this does is it overwrites the files it configured when you initially added the user. These files include:

* installing the users ssh key if it changed or isn't installed yet
* .bashrc
* .gemrc
* adding the user to the 'sudoers' file
* adding the user to the rvm group if rvm is installed
* configuring the .gitconfig
* setting permissions


remove
------

Removes an existing user from the specified environment. This also erases the users home directory in which the user's applications reside. 


install-ssh-key
---------------

Installs the user's local ssh key to the user of the specified environment.


install-root-ssh-key
--------------------

Installs the user's local ssh key to the root user of the specified environment.


$(heavenly user login to staging)
-------------------------------------

Logs the user in to the staging environment.


$(heavenly user login-root to production)
---------------------------------------------

Logs the user in to the production environment as root.