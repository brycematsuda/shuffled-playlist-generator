#!/usr/bin/env ruby

=begin

playlistShuffler.rb

The equivalent to shuffling any playlist/library in iTunes or Banshee.
Except you are given the entire list, not just the next 10/20/30 songs in the list.
Because some people might want to know what the entire play order is.

Only extended m3u files are accepted right now. For now, the script only assumes the m3u is valid
if there is a "#EXTM3U" as the first line, which is required.
Stricter extended m3u validation may be added in the future.

Command line format: ruby playlistShuffler.rb [input.m3u] [optionalOutputName.m3u]

Author/Maintainer: Bryce Matsuda
GitHub: http://github.com/brycematsuda
License: MIT

=end

# File I/O params from command line
fileInput = ARGV[0]
fileOutput = ARGV[1]

# Parameter checking
if !fileInput or !fileInput.end_with? ".m3u" or (fileOutput and !fileOutput.end_with? ".m3u")
  puts("Format: ruby playlistShuffler.rb [input.m3u] [optionalOutputName.m3u]")
  exit
end

# Open .m3u file
begin
  file = File.open(fileInput, "r")
rescue Exception => e
  # File may not exist
  puts("Error: #{fileInput} does not exist. Please enter a valid .m3u file")
  exit
end

puts("Opening #{fileInput}")

# Array for holding all lines except for the first one
songs = Array.new

# 2D Array for holding each individual song "node" formatted as
# ["#EXTINF:{song runtime in seconds},{artist} - {title}", "{song file location}"] 
songPile = Array.new

# Counter
x = 0

# Check for invalid extended m3u files

# Valid extended m3u's must start with #EXTM3U
if file.eof? or !file.readline.eql? "#EXTM3U\n"
  puts("Error: #{fileInput} must start with #EXTM3U to be a valid .m3u file")
  exit
end

# Save all lines except for the first one
# (which we'll add later to the new .m3u file)
while !file.eof?
 line = file.readline
 if !line.eql? "#EXTM3U\n"
  songs.push(line)
end
end

puts("Successfully read #{songs.length / 2} songs.")

# Push each song node to the song pile.
# Every two lines consists of one node.
while x < songs.length
  songPile.push(songs[x, 2])
  x = x + 2
end

# Shuffle the pile
songPile.shuffle!

# Default output file name if no custom name was entered
if !fileOutput
  fileOutput = "shuffled.m3u"
  puts("No custom output file name specified. Using default name of \"#{fileOutput}\"")
else
  puts("Outputting shuffled playlist to \"#{fileOutput}\"")
end

# Output to a new file
begin
  File.open(fileOutput, "w+") do |f|
    f.puts("#EXTM3U\n")
    f.puts(songPile)
  end
  puts("Shuffled playlist successfully exported to #{fileOutput}!")
rescue Exception => e
  # Something might go wrong.
  puts("Uh-oh, something went wrong.\n")
  puts(e)
  exit
end