---
title: Pushing your application
---

Once you have your application and remote environment all set up, you may push it to the server by either **branch**, **tag** or **ref**. For example, let's say just for the sake of this example that I'm using [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/), a very nice branching model. This means I would have a few branches. Let's keep it at **master** and **develop** for this example.

So the **develop** branch would be the unstable development branch. The **master** branch will contain only releases that are "production-ready".

Let's say we have an application, and we want to push it to a _staging environment_ so we can show it to our client.

<% code do %>
gitpusshuten push branch develop to staging
<% end %>

We have now pushed the _develop_ branch of our application to the _staging environment_. The client approves and tells us we can release the product.

<% code do %>
gitpusshuten push branch master to production
<% end %>

And we're live. Now, couple of weeks down the road we've killed quite a good amount of bugs and tagged our application as 1.0.1.  
( example: `git tag 1.0.1` )

We will now release version 1.0.1 of our application, like so:

<% code do %>
gitpusshuten push tag 1.0.1 to production
<% end %>

Now the production environment is running version 1.0.1 of our application. So, ideally, when you use Git and deploy web applications, you actually use Git's _tag_ feature to keep track of what version of your application you're dealing with. Now imagine the scenario that, while you were fixing bugs, you for some reason introduced a new bug which is quite crucial, so crucial that you need to quickly perform a rollback of your application version. If you use tags, this is quite easy.

<% code do %>
gitpusshuten push tag 1.0.0 to production
<% end %>

We went back from version __1.0.1__ to __1.0.0__. Some people believe that web applications shouldn't have version numbers. For this reason, I also included the ability to push by __ref__. So, assuming we need did not tag our commits, we look in our `git log` an look for the last "stable" commit and extract the correct __ref__. Using this __ref__ we can now run the following command:

<% code do %>
gitpusshuten push ref 9565d22d96d422e7fea106d88f49bd493513986c to production
<% end %>

And that's it. So regardless of whether you do or do not use tags, or whether you do or do not use a branching strategy, Git Pusshuten should work.

One last example, say you have a social application that has a beta program, and you've set up a different environment/codebase for that. Then you could use Git Pusshuten for that as well. Inside the configuration file, just specify the beta environment configuration and run:

<% code do %>
gitpusshuten push develop to beta
<% end %>

Or if you created a separate __beta__ branch for this:

<% code do %>
gitpusshuten push beta to beta
<% end %>

Hooks
-----

When pushing an application, it triggers your _"pre"_ and _"post"_ deploy hooks.
Depending on what you have configured, or what modules you've included, they will be run accordingly. Pushing is also the only time the _"pre"_ and _"post"_ hooks invoke. Other commands do not invoke them. [Read more about Hooks](/documentation/getting-started/deployment-hooks/)