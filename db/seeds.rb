# Loads all the data the DB needs for users to get up and running
# As of now all it needs it card data

require 'rubygems'
require 'nokogiri'   
require 'open-uri'

##Load all the cards from duel links wiki
BASE_CARD_URL = "http://duellinks.gamea.co/c/krqawp02"

#Load the web page holding the list of all cards
cards_page = Nokogiri::HTML(open(BASE_CARD_URL))
#Grab the divs with unique cards
pages = cards_page.css("div.article-part tr")
pages = pages-cards_page.css("div.article-part tr[class='bgcolor-grey-thin']")
length = pages.length;
counter=0;
##For each url-contaning div, load the new html file and 
##Create a new card object based on the data
pages.each{ |link|
    
    #Open the cards web page
    card_url= "http://duellinks.gamea.co"+link.css("td a")[0]['href']
    card_page= Nokogiri::HTML(open(card_url))
    
    # Create the new card if it isnt added to the database, otherwise find it
    c = Cards.find_or_initialize_by(name: card_page.css("div.article-part")[0].css("h2").text)
    # Make sure the key is the url we find it at
    c.update_attribute(:key, link.css("td a")[0]['href'])
    
    #Grab the div that holds the image
    image = card_page.css("div.article-part")[1].css("div div img")[0]['src']
    download = open("http://duellinks.gamea.co#{image}")
    
    #Save the image in the assets/image folder
    IO.copy_stream(download, "./app/assets/images/card_#{c.id}.jpg")
    puts image
    
    #Grab the div that holds the stats
    stats = card_page.css("div.article-part")[2].css("div table tr")
    
    # Print the card name for testing
    puts card_page.css("div.article-part")[0].css("h2").text
    
    #For each fow in the stats div
    stats.each{|s|
        
        # The attribute is determined by the first item
        # The value is in the second item
        key = s.css("td")[0].text
        
        if s.css("td")[1].text==""
            puts "heyyyyyyyyyy"
        end
        
        case key.strip
            
            ##Determines if its a magic card, trap, effect monster, ritual, norm, etc.
            # Card type and type are the same thing
            when "Card type"
                c.update_attribute(:card_type , s.css("td")[1].text.to_s)
                puts s.css("td")[1].text.to_s
                puts "Card type updated"
            when "Type"
                c.update_attribute(:card_type , s.css("td")[1].text.to_s)
                puts s.css("td")[1].text.to_s
                puts "Type updated"
            
            ##For Monster cards only
            when "Attribute"
                c.update_attribute(:attribute_value , s.css("td")[1].text.to_s)
                puts s.css("td")[1].text.to_s
                puts "Attribute updated"
            when "Monster Type"
                c.update_attribute(:monster_type , s.css("td")[1].text.to_s)
                puts s.css("td")[1].text.to_s
                puts "Monster type updated"
            when "Level"
                c.update_attribute(:level , s.css("td")[1].text[1..-1].to_i)
                puts s.css("td")[1].text[1..-1].to_i
                puts "Level updated"
            when "ATK"
                c.update_attribute(:attack , s.css("td")[1].text.to_i)
                puts s.css("td")[1].text.to_i
                puts "Attack updated"
            when "DEF"
                c.update_attribute(:defense , s.css("td")[1].text.to_i)
                puts s.css("td")[1].text.to_i
                puts "Defense updated"
            
            ##For magic and Trap cards only
            when "Property"
                c.update_attribute(:property , s.css("td")[1].text.to_s)
                puts s.css("td")[1].text.to_s
                puts "Property updated"
            when "Card Effect Type"
                c.update_attribute(:card_effect_type , s.css("td")[1].text.to_s)
                puts s.css("td")[1].text.to_s
                puts "Card effect type updated"
            
            else
        end
    }
    
    puts "finished with #{counter}/#{length}"
    counter+=1;
    
}