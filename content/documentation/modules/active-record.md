---
title: Active Record
---

You can add Active Record to the modules in your configuration file, like so:

<% code do %>
pusshuten "My Application", :staging do
  modules do |m|
    m.add :active_record
  end
end
<% end %>

With Active Record enabled, it'll add a post deploy hook to the stack of deploy hooks that invokes the `rake db:migrate` command after pushing your application to ensure the database is up to date.