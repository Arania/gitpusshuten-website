---
title: "Module: Active Record"
---

You can add Active Record to the modules in your configuration file, like so:

<% code do %>
pusshuten "My Application", :staging do
  modules do |m|
    m.add :active_record
  end
end
<% end %>

With Active Record enabled, it'll add two post deploy hooks to the stack.


First of all, to enable multi-environment databases, the first hook will look for the database.yml.{environment}.

For example, if we run: `gitpusshuten push branch master to production` it will look for **app_root/config/database.yml.production**. If the file exists, it'll rename it from **database.yml.production** to **database.yml**, overwriting (if it exists) the **config/database.yml**.

If it is not found, it will ignore this process and leave the **config/database.yml** as is.

So for every environment you have you could appended the environment as extension to the database.yml file. **database.yml.staging**, **database.yml.production**, **database.yml.beta** etc. Or, if every environment uses the same database, just ignore this step and just stick with your regular **database.yml**.

All of this happens on the server and it won't mess up your local development environment.

Next, it'll invoke the `rake db:create` and `rake db:migrate` command after pushing your application to ensure the database is up to date.