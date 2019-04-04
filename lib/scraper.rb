require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #open the index we're going to scrape.
    doc = Nokogiri::HTML(open(index_url))
    # then start with an empty array
    an_array = []
    #...damn that array looks good.
    #next let's iterate over that entire index we declared as "doc", and assign elements to variables that we can call on later that represent the data we want to capture.
    doc.css("div.student-card").each do |info|
      name = info.css(".student-name").text
      location = info.css(".student-location").text
      url = info.css("a").attribute("href").value
      #then let's take that info, and give the info(values) certain keys and put them into a hash.
      student_hash = {:name => name,
                      :location => location,
                      :profile_url => url}
      #shovel that hash into that good looking array.
      an_array << student_hash
      end
      #return said array.
    an_array
  end

  def self.scrape_profile_page(profile_url)
      #open the profile URL we're scraping and then establish our empty hash. All great hashes start empty.
      page = Nokogiri::HTML(open(profile_url))
      info = {}
      #we're going to iterate through each of the individual icon containers that hold the links to the certain social media linked to the profile. IF those links hold the keyword we argue, then we're going to capture that link.
      container = page.css(".social-icon-container a").map{|icon| icon.attribute("href").value}
      container.each do |link|
        #conditional listing whether the profile contains one or many of the social media links.
        if link.include?("twitter")
          info[:twitter] = link
        elsif link.include?("linkedin")
          info[:linkedin] = link
        elsif link.include?("github")
          info[:github] = link
        elsif link.include?(".com")
          info[:blog] = link
        end
      end
      #every profile has a quote and a bio though, so we'll always scrape that jawn.
      info[:profile_quote] = page.css(".profile-quote").text
      info[:bio] = page.css("div.description-holder p").text
      #then we'll return the final product, the list of the student info.
      info
  end

end

