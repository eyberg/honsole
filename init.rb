require "rubygems"

require File.dirname(__FILE__) + '/lib/honsole'

Heroku::Command::Help.group("Honsole") do |group|
  group.command "honsole",                "pop a multi-line enabled console"
end
