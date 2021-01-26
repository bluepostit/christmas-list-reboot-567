# Display welcome message
# Store list of actions
# Set user action as empty
# Set gift list as empty list
# Loop until user action is 'quit'
#   Display list of actions
#   Ask user for an action
#   Get user action and store it
#   If action is 'list':
#     Iterate over the list. For each item:
#       Display it with its bought status
#   If action is 'add':
#     Display list of items
#     Ask user for the name of the gift to add
#     Get gift name from user and store it
#     Add item to the gift list - not bought
#   If action is 'delete':
#     Display the gift list
#     Ask the user for the index of the gift to delete
#     Get the index from the user and store it
#     Delete the item by index from the list
#   If action is 'mark':
#     Display the gift list
#     Ask the user for the index of the gift to mark as bought
#     Get the index from the user and store it
#     Mark the relevant gift as bought
#   If action is 'ideas':
#     Ask user for ideas keyword
#     Get the keyword from the user and store it
#     Get list of products by scraping website for keyword and store it
#     Display first X results
#     Ask user for the index of the idea to add
#     Get idea index from user and store it
#     Get the idea/product from the ideas list by this index and store it
#     Add it to the gift list
# End loop
# Print goodbye message

require 'open-uri'
require 'nokogiri'

def user_index
  puts "Please enter the number of the gift"
  print '> '
  index = gets.chomp.to_i - 1
end

def list_gifts(gifts)
  puts '== Your gifts: =='
  gifts.each_with_index do |gift, index|
    # bought = <condition> ? <truthy part> : <falsy part>
    bought = gift[:bought] ? 'x' : ' '
    puts "#{index + 1}. [#{bought}] #{gift[:name]}"
  end
end

def scrape_ideas(keyword)
  # filepath = "results.html"
  # 1. We get the HTML page content
  # html_content = File.open(filepath)
  html_content = open("https://www.etsy.com/search?q=#{keyword}").read
  # 2. We build a Nokogiri document from this file
  doc = Nokogiri::HTML(html_content)

  ideas = []
  # 3. We search for the correct elements containing the items' title in our HTML doc
  doc.search('.v2-listing-card .v2-listing-card__info .text-body').each do |element|
    # 4. For each item found, we extract its title and print it
    ideas << element.text.strip
  end
  return ideas.take(5)
end

puts "Welcome to your Christmas shopping list"

actions = %w[list add delete mark ideas quit]

user_action = ''
gifts = [
  {
    name: 'book',
    bought: false
  },
  {
    name: 'socks',
    bought: false,
  },
  {
    name: 'headset',
    bought: true
  }
]

until user_action.match?(/quit/i)
  puts 'Please choose an action'
  puts actions.join('|')
  print '> '
  user_action = gets.chomp
  case user_action
  when 'add'
    list_gifts(gifts)
    puts 'Please enter the gift name to add'
    print '> '
    name = gets.chomp
    gifts << { name: name, bought: false }
  when 'list'
    list_gifts(gifts)
  when 'delete'
    list_gifts(gifts)
    index = user_index()
    gifts.delete_at(index)
  when 'mark'
    list_gifts(gifts)
    index = user_index
    gifts[index][:bought] = true
  when 'ideas'
    puts "Please enter the keyword to search for ideas with"
    keyword = gets.chomp
    ideas = scrape_ideas(keyword)
    ideas.each_with_index do |idea, index|
      puts "#{index + 1}. #{idea}"
    end
    index = user_index
    idea = ideas[index]
    gifts << { name: idea, bought: false }
  end
  puts ""
end

puts 'Goodbye!'
