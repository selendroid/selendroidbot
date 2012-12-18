#!/usr/bin/env ruby

require 'selbot2'

Cinch::Bot.new {
  configure do |c|
    c.server = "irc.freenode.net"
    c.nick   = "selendroidbot"
    c.channels = Selbot2::CHANNELS
    c.plugins.plugins = [
      Selbot2::Issues,
      Selbot2::Revisions,
      Selbot2::Commits,
      Selbot2::Wiki,
      Selbot2::Youtube,
      Selbot2::Notes,
      Selbot2::Seen,
#      Selbot2::SeleniumHQ,
      Selbot2::CI,
      Selbot2::Google,
<<<<<<< HEAD
#      Selbot2::WhoBrokeIt
=======
      Selbot2::Log,
      Selbot2::WhoBrokeIt
>>>>>>> adding local logging of chat
    ]

    # if File.exist?("twitter.conf")
    #   c.plugins.plugins << Selbot2::Twitter
    # end
  end

  Selbot2::HELPS << [':help', "you're looking at it"]
  on :message, /:help/ do |m|
    helps = Selbot2::HELPS.sort_by { |e| e[0] }
    just = helps.map { |e| e[0].length }.max

    helps.each do |command, help|
      m.user.privmsg "#{command.ljust just} - #{help}"
    end
  end

  Selbot2::HELPS << [':log', "link to today's chat log at illictonion"]
  on :message, /:log/ do |m|
    m.reply "https://raw.github.com/selendroid/irc-logs/master/#{(Time.new.gmtime - 25200).strftime('%Y/%m/%d')}.txt"
  end

  [
    {
      :expression => /:newissue/,
      :text       => "https://github.com/selendroid/selendroid/issues/new",
      :help       => "link to issue the tracker"
    },
    {
      :expression => /:(source|code)/,
      :text       => "https://github.com/selendroid/selendroid",
      :help       => "link to the source code"
    },
    {
      :expression => /:downloads/,
      :text       => "https://github.com/selendroid/selendroid/releases",
      :help       => "links to downloads pages"
    },
    {
      :expression => /:gist/,
      :text       => "Please paste >3 lines of text to https://gist.github.com",
      :help       => "link to gist.github.com",
    },
    {
      :expression => /:(gist-?usage|using-?gist)/,
      :text       => "https://github.com/radar/guides/blob/master/using-gist.markdown",
      :help       => "how to use gists",
    },
    {
      :expression => /:ask/,
      :text       => "If you have a question, please just ask it. Don't look for topic experts. Don't ask to ask. Don't PM. Don't ask if people are awake, or in the mood to help. Just ask the question straight out, and stick around. We'll get to it eventually :)",
      :help       => "Don't ask to ask."
    },
    {
      :expression => /:cla(\W|$)/,
      :text       => "http://goo.gl/pAvxEI",
      :help       => "link to Selenium's CLA"
    },
    {
       :expression => /:ci/,
       :text => "http://ci.selendroid.io/",
       :help => "links to our ci"
     },
     {
       :expression => /:docs/,
       :text => "http://selendroid.io/",
       :help => "links to docs"
     },
    {
      :expression => /:snapshot/,
      :text       => "http://ci.selendroid.io/job/selendroid/io.selendroid$selendroid-standalone/",
      :help       => "links to latest snapshot build"
    },
    {
      :expression => /:(mailing)?lists?/,
      :text       => "http://groups.google.com/group/selendroid",
      :help       => "link to mailing lists"
    },
    {
      :expression => /:change(log|s)\b/,
      :text       => ".NET: http://goo.gl/zBIjE | Java: http://goo.gl/5B23U | Ruby: http://goo.gl/yN6Qm | Python: http://goo.gl/7BtCb | IDE: http://goo.gl/50vLB | IE: http://goo.gl/VYNFyb",
      :help       => "links to change logs"
    },
    {
      :expression => /:(testcase|repro|example|sscce)/i,
      :text       => "Please read http://sscce.org/",
      :help       => "Link to 'Short, Self Contained, Correct (Compilable), Example' site"
    },
    {
      :expression => /:(spec|w3c?)/i,
      :text       => "http://dvcs.w3.org/hg/webdriver/raw-file/tip/webdriver-spec.html | http://dvcs.w3.org/hg/webdriver/",
      :help       => "Links to the WebDriver spec."
    },
    {
      :expression => /:kittens\b/,
      :text       => "Before you say you cannot provide html, think of the kittens! http://jimevansmusic.blogspot.ca/2012/12/not-providing-html-page-is-bogus.html",
      :help       => "Letting users know they need to provide html"
    }
  ].each do |cmd|
    Selbot2::HELPS << [cmd[:expression].source, cmd[:help]]
    on(:message, cmd[:expression]) { |m| m.reply cmd[:text] }
  end

}.start

