require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(url)
    info = Nokogiri::HTML(open(url))
    names = info.css('.student-name').text.split
    students = []

# binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end

