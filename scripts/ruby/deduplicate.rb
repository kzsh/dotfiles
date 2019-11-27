#!/usr/bin/env ruby

require 'set'
found = Set.new
$stdout.sync = true
ARGF.each do |line|
  unless found.include? line
    found << line
    puts line
  end
end
