require "open-uri"
require "nokogiri"

USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"

def fetch_top_movie_urls
  top_movies_url = "https://www.imdb.com/chart/top/"
  html_file = URI.parse(top_movies_url).open("Accept-Language" => "en-US", "User-Agent" => USER_AGENT).read
  doc = Nokogiri::HTML(html_file)

  links = []
  # TODO: return top movies URLs
  doc.search('ul.sc-a1e81754-0 li a.ipc-title-link-wrapper').first(5).each do |link|
    links << ("https://www.imdb.com" + link.attributes['href'].text).match(/(^.*)\?/)[1]
  end
  links

end

def scrape_movie(url)
  html_file = URI.parse(url).open("Accept-Language" => "en-US", "User-Agent" => USER_AGENT).read
  doc = Nokogiri::HTML(html_file)

  # TODO: return movie info hash
  {
    title: doc.search('h1').text,
    year: doc.search('ul.sc-ec65ba05-2 a')[0].text.to_i,
    storyline: doc.search('span.sc-fbb3c9a4-0').text
  }
end
