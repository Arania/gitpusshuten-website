---
title: Pushing your application
---

Once you have your application all setup, you may push it to the server by either **branch**, **tag** or **ref**. For example, let's say that I'm using [Git Flow](http://nvie.com/posts/a-successful-git-branching-model/), a VERY nice branching model. This means I would have a few branches. Let's keep it at **master** and **develop** for this example.

So the **develop** branch would be the unstable, development branch. The **master** branch will contain only "releases".

Obviously we would not want to push the **develop** branch to the **production** environment, because it is considered "unstable". This is where the "staging" environment comes in. So let's go ahead and push our **develop** branch to our **staging** environment, shall we?

<% code do %>
gitpusshuten push branch develop to staging
<% end %>

Done. Now, assuming you have set up your DNS properly, and your vhost (which you can manage locally when using the Apache or NginX module), you should be able to for example, access **http://staging.mydomain.com/** and voila! Next, we've confirmed everything is working well and we are ready to release the next version of our application. We have the **master** branch ready for the push. All we do is:

<% code do %>
gitpusshuten push branch master to production
<% end %>

And we're live.

But uh-oh! A CRUCIAL bug has been discovered and we quickly need to rollback to the previous version. Well, if you actually `git tag` your applications, this is a very easy procedure!

<% code do %>
gitpusshuten push tag 1.2.1 to production
<% end %>

And there you go, assuming our release was version **1.2.2**, we now rolled back to **1.2.1** using the above command.
Now, don't worry, if you don't tag your releases, you can even push by **ref**! Look up your ref in Git and run the following command:

<% code do %>
gitpusshuten push ref 81f2e2a6b80741a0f1a96c7663802dd1935567c7 to production
<% end %>

And there you go.