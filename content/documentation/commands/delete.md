---
title: "Command: Delete"
---

Deletes an entire application from the remote server.
If you for example have the following configuration:

<% code do %>
pusshuten 'My Application', :production do
  ...
end
<% end %>

Then when you push your application, it'll be deployed to `/var/applications/my_application.production` on the server.

If you wish to delete the `/var/applications/my_application.production` directory, you simply run the following command:

<% code do %>
gitpusshuten delete production environment
<% end %>

and the `my_application.production` directory will be removed.