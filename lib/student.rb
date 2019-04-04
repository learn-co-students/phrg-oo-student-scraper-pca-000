require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  #The '.send' method then calls the method name that is the key’s name, with an argument of the value.
  def initialize(student_hash)
    self.send("name=", student_hash[:name])#"name=" is the key, student_hash[:name] the value.
    self.send("location=", student_hash[:location])#same thing except location.
    # binding.pry
    @@all << self
  end

  # contacts.each do |person, contact_details_hash|
  # contact_details_hash.each do |attribute, data|
  def self.create_from_collection(students_array)#an array of names as keys, locations as values
    students_array.each do |student_hash| #each student is a hash
    Student.new(student_hash) #make a new Student object with each name & location.
    # binding.pry
    end
  end

  def add_student_attributes(attributes_hash)
    self.send("twitter=", attributes_hash[:twitter])
    self.send("linkedin=", attributes_hash[:linkedin])
    self.send("github=", attributes_hash[:github])
    self.send("blog=", attributes_hash[:blog])
    self.send("profile_quote=", attributes_hash[:profile_quote])
    self.send("bio=", attributes_hash[:bio])
    # binding.pry
  end

  def self.all
    @@all
  end
end

