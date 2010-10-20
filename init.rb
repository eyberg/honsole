require "rubygems"

begin
  require "highline/import"
rescue
  puts "fuuu\n\tyou need the highline"
end

require File.dirname(__FILE__) + '/lib/honsole'

Heroku::Command::Help.group("Honsole") do |group|
  group.command "honsole",                "pop a multi-line enabled console"
end
