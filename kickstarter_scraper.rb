# required libraries and modules
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html') # opens the file
  kickstarter = Nokogiri::HTML(html) # reads into the vairable kickstarter
  projects = {}
  # Iterating through the projects
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
    :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
    :description => project.css("p.bbcard_blurb").text,
    :location => project.css("ul.project-meta li a").text,
    :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  # returning the projects hash generated above
  projects
end