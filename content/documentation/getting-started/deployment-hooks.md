---
title: Deployment hooks
---

The other file at your disposal is the `.gitpusshuten/hooks.rb` file, in which you can define `pre` and `post` deploy hooks for the specified environments. This file doesn't really need much explanation.

<% code do %>
perform_on :staging, :production do
  pre "Echo out something" do
    run 'echo "Ready to Deploy"'
  end
  
  post "Restart Passenger" do
    run 'mkdir -p tmp; touch tmp/restart.txt'
  end
end
<% end %>

All these commands will run inside your application root on the remote server for the specified environment.

You may add as many `pre` and `post` deploy hooks as you want. You can also specify on which environment they have to invoke.

__Modules__ may also add deploy hooks. For example, the __Passenger__ module, when defined in your `.gitpusshuten/config.rb`, will add a deploy hook that already runs this command:

<% code do %>
post "Restart Passenger" do
  run 'mkdir -p tmp; touch tmp/restart.txt'
end
<% end %>

So you don't have to.