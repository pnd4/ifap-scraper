#!/usr/bin/env ruby

## pnd4 -- 05.30.15
# Imagefap Scraper in Ruby.. Since I a lot of the ones I had tried were broken.

require 'mechanize'

print "Enter the gallery URL: "

# target is the gallery URL (the one with 24 pics/pg)
#target = "http://www.imagefap.com/pictures/5387123/Erna?gid=5387123&view=0"
target = gets.chomp

# Fix-up URL to see all photo's without pagination
target.gsub!(/view=0/,"view=2")

scraper = Mechanize.new
# page is the scraped mechanize object-instance to work on
page = scraper.get("#{target}")

# purls is the set of photo urls from the index page we will find our preciouses
purls = page.links_with(:href => /photo/)

# Grab 'mainPhoto' from each element in purls
puts "Downloading .. "
purls.each do |pic|
    preciouses = pic.click.image_with(:id => /mainPhoto/)
    puts "#{preciouses}"
    preciouses.fetch.save
end

puts "Enjoy faggot!"
