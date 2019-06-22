require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    doc.css("div.roster-cards-container").each do |profile|
      profile.css("div.student-card a").each do |person|
        scraped_students << {
        :name => person.css("h4.student-name").text,
        :location => person.css("p.student-location").text,
        :profile_url => person.attribute("href").value
        }
      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    doc.css("div.social-icon-container a").each do |url|
      item = url.attribute('href').value
      if item.include?("twitter")
        scraped_student[:twitter] = item
      elsif item.include?("linkedin")
        scraped_student[:linkedin] = item
      elsif item.include?("github")
        scraped_student[:github] = item
      else
        scraped_student[:blog] = item
      end
    end
    scraped_student[:profile_quote] = doc.css("div.profile-quote").text
    scraped_student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    scraped_student
  end

end

