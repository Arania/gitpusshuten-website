---
title: Updates
description: "Git Pusshuten updates, the Git based deployment Ruby Gem that simplifies application deployment."
keywords: git, git pusshuten, guides, deployment, server, ubuntu, provisioning, updates
---

This page will contain all version updates that get released. These updates will consist of mainly the most important changes that've been made. Smaller details may be omitted.

This page also serves as a simple blog for notifications.

<% all_items = find_and_sort_updates(@items) %>

<% all_items[0..2].each do |item| %>
  
  <h1><%= item[:title] %></h1>
  <span class="date">posted: <%= item[:date] %></span>

  <%= item.raw_content %>

<% end %>

<% if all_items.count > 3 %>
  <span class="more">The sidebar on the right contains a list of older updates.</span>
<% end %>