---
title: Delete
---

Deletes an entire application from the remote server. e.g. `/var/applications/my_application.staging` will be removed.

You specify the environment of the application you wish to delete.

<% code do %>
gitpusshuten delete staging environment
gitpusshuten delete production environment
<% end %>