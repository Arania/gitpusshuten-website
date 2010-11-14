---
title: Push
---

Pushes your application to the specified environment.

You can push your application by **branch**, **tag** or **ref**.

<% code do %>
gitpusshuten push branch develop to staging
gitpusshuten push tag 1.0.3 to staging
gitpusshuten push ref 2dbec02aa0b8604b8512e2fcbb8aac582c7f6a73 to production
<% end %>