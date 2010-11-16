---
title: Configuring your configuration file
---

Upon __initialization__ of GitPusshuten with your application you get a `.gitpusshuten/config.rb` file.

This file will basically contain all the "environment" configuration.
Here is a sample of what the _minimum_ configuration looks like.

<% code do %>
pusshuten 'My Application', :staging, :production do
  authorize do |a|
    a.user       = 'gitpusshuten'
    a.ip         = '123.45.678.90'
  end

  applications do |a|
    a.path = '/var/applications/'
  end
end
<% end %>

This is the bare minimum, and with this, you can already start pushing your application to multiple environments. In this case, you can push it to a **staging** and **production** environment. We will get to the **pushing** of your application in a later chapter. 

Let's take a look at the individual parts of this configuration block.

<% code do %>
pusshuten 'My Application', :staging, :production do
<% end %>

The `pusshuten` method is used to define (or overwrite if one already exists) a configuration block. The first argument would be the name of your application. The second argument takes an array of "environments". You can add as many as you like. We are now defining the `:staging, :production` environments.

You can define multiple `pusshuten` configuration blocks. For example, you could define something like this first, where you define the `:staging` and `:production` environments in one configuration block.

<% code do %>
pusshuten 'My Application', :staging, :production do
  authorize do |a|
    a.user       = 'gitpusshuten'
    a.ip         = '123.45.678.90'
  end
  ...
end
<% end %>

Then, you can define another block, just for the `:production` environment, like so:

<% code do %>
pusshuten 'My Application', :production do
  authorize do |a|
    a.ip         = '098.76.543.21'
  end
end
<% end %>

What you accomplished with this is that you defined the `:staging` and `:production` environments, and made them completely identical, except for the **ip** address, since the `:production` was re-defined and overwrote the **ip** configuration, which means the `:production` environment will run on a different server than the `:staging` environment.

_"So, what exactly is an environment and why would I want to use multiple?"_

Well, for one, it's nice to have a remote environment, that isn't the _production_ environment because then you can deploy an unstable or unconfirmed/unfinished version of your application. This could be useful if you're working for a client and want to show progress. Or, if you're working on a SaaS application and want to see if it deploys correctly to your remote environment before pushing it to the production environment (which is what all your user access). Maybe you want to have a `:beta` environment which is only accessible to beta users.

And there are probably more useful ways to utilize this feature.

**Next, let's talk about the actual "configuration".**

<% code do %>
authorize do |a|
  a.user       = 'gitpusshuten'
  a.password   = 'my-password'
  a.passphrase = 'my-ssh-passphrase'
  a.ip         = '123.45.678.90'
  a.port       = '22'
end
<% end %>

These are the variables for your remote environment.  

**user** is required. This will become a new user on your remote server which will handle various things, such as deployments.


**password** is not required. Either set this, or have an SSH key, or be prompted every time you connect to your remote environment.

**passphrase** is not required. Some people use "passphrases" which are can set for your SSH keys. If you do that as well, you can specify your passphrase here.

**ip** is required. This will be the ip that points to your server.

**port** is not required. If this is not specified, it defaults to 22, which is the default SSH port.

**Next, is the applications block**

<% code do %>
applications do |a|
  a.path = '/var/applications/'
end
<% end %>

**path** is required. This is a very simple block, since it only takes one parameter which is the path to the where you would like to store all your applications for the specified user.

And that covers it for the __core__ functionality of GitPusshuten. However, where GitPusshuten really shines is when you start using __modules__. So to briefly show you a module setup, look at the code block below.

<% code do %>
modules do |m|
  m.add :bundler
  m.add :active_record
  m.add :passenger
  m.add :nginx
  m.add :rvm
  m.add :mysql
end
<% end %>

I will not go into detail about what these modules actually do. But I will tell you this much:

_"With the above defined modules, you've defined your application's environment. With this in place you can have your application up and running on a **new** Ubuntu installation in a matter of minutes."_

Check out the individual module pages to learn more about them.