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
# End loop
# Print goodbye message

def list_gifts(gifts)
  puts '== Your gifts: =='
  gifts.each_with_index do |gift, index|
    puts "#{index + 1}. #{gift}"
  end
end

puts "Welcome to your Christmas shopping list"

actions = ['list', 'add', 'delete', 'quit']

user_action = ''
gifts = ['book', 'socks', 'headset']

# gifts = {
#   'book' => false,
#   'socks' => true
# }

# gifts = [
#   {
#     name: 'book',
#     bought: false
#   },
# ]

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
    gift = gets.chomp
    gifts << gift
  when 'list'
    list_gifts(gifts)
  when 'delete'
    list_gifts(gifts)
    puts "Please enter the number of the gift to delete"
    print '> '
    index = gets.chomp.to_i - 1
    gifts.delete_at(index)
  end
  puts ""
end

puts 'Goodbye!'
