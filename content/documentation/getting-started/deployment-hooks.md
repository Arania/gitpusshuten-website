---
title: Deployment hooks
---

Aside of the configuration file that gets generated for you, there is also a **hooks.rb** file.
In here you can define any **environment specific** pre and post deployment hooks on the remote server.

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

Now, I couldn't think of anything creative for the **pre** deploy hook, so for the sake of this example I'll just echo out something. As you might have guessed, the **pre** hook is what gets performed on the server before you push your application. The **post** hook is what gets performed after the application has been deployed.

You may add as many **pre** and **post** deploy hooks as you want. You can also specify on which environment they have to invoke.