#!/usr/imports/bin/ruby

require_relative "maze.rb"

if ARGV.length != 2
  fail "usage: runner.rb <command> <filename>"
end

command = ARGV[0]
fileName = ARGV[1]

puts main(command, fileName)