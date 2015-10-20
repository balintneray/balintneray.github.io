---
layout: post
title: "Creating a GitHub Page with Jekyll"
excerpt: "First post explaining the existence of this site"
tags: [tutorial, github, jekyll]
modified: 2014-11-1
comments: true
---

## The Website(s)

In the past 4-5 weeks I have been working on my personal webiste(s) in my free time. Okay, wait, what?! Why would I work on website(s), especially in my free time? And, why would I need a website in the first place? These are two relevant questions, but I don't really know the answer to the second one ... maybe time will tell. I had many different ideas and reasons, but none of them are interesting from the perspective of this post. This website building something has come, I guess, as a natural consequence of my unavoidable and increasingly frequent encounters with programming. However alienated, it seems to be an essential and elementary skill for more and more professions, even for sociology (... okay, maybe one could argue, it's just computational sociology ... maybe ... but let's not go into this right now). Anyway, I took this project as a learning process without obligations.
<br><br>
I started off with [Wix](http://www.wix.com), because in my opinion this is probably the best free website generator for personal purposes, which features an incredible amount of nice themes and gives you a lot of room for creativity. However, I soon realised that one of its disadvantages is its cumbersome approach for blogging. So I switched to [Wordpress](https://wordpress.org), arguably one of best solution for blogging. After spending a few days on playing around with the pre-made themes, I realised that I do enjoy the "how to ..." learning process much more than I actually want my website to be done. Hence, I started to search for something more challenging, that gives me more freedom rather on the back-end side if things than on the front-end.
<br><br>
So I went on the geeky road and found the [GitHub Pages](https://pages.github.com), hosted by [GitHub](http://github.com) and powered by [Jekyll](http://jekyllrb.com/). After several failed attempts - a vital part of the learning process - I eventually figured how to set up the page, using [Michael Rose's](https://mademistakes.com) [Minimal Mistakes project](http://github.com/mmistakes). So far I am convinced that this is a great solution for a personal resume type of website and a blog too. It is much less fancy than the ones you could create on Wix or Wordpress, but it is yours, it inspires you to keep working on it, it is challenging and it makes you care about the content rather than the surface. So, here is a short summary slash tutorial about the project for those who are interested.  
And if you were searching for something more user-friendly, you might want to take a tour on [WebsiteToolTester](http://www.websitetooltester.com/en/website-builder-reviews/).

## On GitHub

Alright, so one of the benefits of GitHub Pages is ease of collaboration. Changes you make in the repository are automatically synced, so if your site’s hosted on GitHub, it’s as up-to-date as your GitHub repository. Plus, you can reach and edit your website online via your Git account from everywhere.
If you are new to GitHub, you might want learn [how to set up your own Git](https://help.github.com/articles/set-up-git/). If you are unfamiliar with or have significant aversion to code-writing, then GitHub is not necessarily the best choice for you. But if your work / interest involves some sort of programming, then you should definitely check it out.

## With Jekyll

On GitHub you can start building your site from scratch or use one of the pre-made templates. Either way, you have to learn a little bit about Jekyll, starting from the [installation](http://jekyllrb.com/docs/installation/). Jekyll is a fantastic website generator that’s designed for building minimal, static blogs to be hosted on GitHub Pages. If you would like to create a new Jekyll site using Minimal Mistakes follow, these steps:

1. Fork the [Minimal Mistakes repo](http://github.com/mmistakes/minimal-mistakes/fork).
2. Clone the repo you just forked and rename it according to the [GitHub Pages guide](https://pages.github.com).
3. [Install Bundler](http://bundler.io) `gem install bundler` and Run `bundle install` to install all dependencies ([Jekyll](http://jekyllrb.com/), [Jekyll-Sitemap](https://github.com/jekyll/jekyll-sitemap), [Octopress](https://github.com/octopress/octopress), etc.)
4. Start working on your site by using the guide in the [Minimal Mistakes project](http://github.com/mmistakes).
<br><br>

<i class="fa fa-info-circle"></i> *Note*: these `highlighted texts` are console commands for Mac users.
{: .notice}

## And Markdown

Jekyll makes content creating and blogging very easy as it automatically develops HTML / XHTML files from Markdown files. Markdown is essentially a text-to-HTML conversion tool. It provides you with really simple and convenient way to write (and to read) plain text. Learning the basics of the language is relatively fast, and you can check out the Test Posts here (such as the [Test Post with Markdown](http://balintneray.github.io/sample-post/) ) or find great guides such as [this one](http://markdown-guide.readthedocs.org/en/latest/) or [this one](https://daringfireball.net/projects/markdown/basics).
<br><br>
Oh, and one more thing. For all of these, you will probably need a good text editor software. If you don't have a favourite yet, I would suggest you in general to go with [SublimeText](http://www.sublimetext.com), but Mac users should give a try to [Atom](https://atom.io), yet an other GitHub project, works really well for me!

<div markdown="0">
  <a href="https://mac.github.com" class="btn">Install GitHub Mac</a>
  <a href="https://atom.io" class="btn">Install Atom</a>
	<a href="http://bundler.io" class="btn">Install Bundler</a>
	<a href="http://jekyllrb.com/docs/installation/" class="btn">Install Jekyll</a>
</div>

<figure>
	<img src="/images/baracktocat.jpg">
  <figcaption><a href="https://octodex.github.com" title="Yes we code">GitHub Octocodex</a>.</figcaption>
</figure>
