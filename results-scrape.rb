#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'json'
require 'colored'
require 'pry'

route_ids = []

# change to how far back in pagination we should scrape
# some cities don't go too far back
(1..5).each do |page|
  url = "http://runkeeper.com/search/routes/#{page}?distance=&lon=-74.014&location=10004&activityType=BIKE&lat=40.704"
  html = Nokogiri::HTML(open(url))
  cyclists = html.css(".thumbnailUrl")
  cyclists.each do |cyclist|
    link = cyclist.attributes["href"].value
    route_ids << link
  end
  puts "#{page}. #{url}".green unless route_ids == []

  sleep [1.1,2.2,3.3].sample
end

File.open("results/nyc.json","w") do |f|
  f.write(route_ids.to_json)
end
