require "yaml"
require "json"

require_relative "scraper"

urls = fetch_top_movie_urls

movies = []
urls.each do |url|
  info = scrape_movie(url)

  movies << info

  # puts "------------------------------"
  # puts "Title: #{info[:title]}"
  # puts "Year: #{info[:year]}"
  # puts "Plot: #{info[:storyline]}"
end

File.open('movies.yml', 'wb') do |file|
  file.write(movies.to_yaml)
end
