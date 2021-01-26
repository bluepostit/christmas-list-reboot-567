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

def list_gifts(gifts)
  puts '== Your gifts: =='
  gifts.each_with_index do |gift, index|
    # bought = <condition> ? <truthy part> : <falsy part>
    bought = gift[:bought] ? 'x' : ' '
    puts "#{index + 1}. [#{bought}] #{gift[:name]}"
  end
end

puts "Welcome to your Christmas shopping list"

actions = ['list', 'add', 'delete', 'mark', 'quit']

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
    puts "Please enter the number of the gift to delete"
    print '> '
    index = gets.chomp.to_i - 1
    gifts.delete_at(index)
  when 'mark'
    list_gifts(gifts)
    puts "Please enter the number of the gift to mark as bought"
    print '> '
    index = gets.chomp.to_i - 1
    gifts[index][:bought] = true
  end
  puts ""
end

puts 'Goodbye!'
