
require './binary_search_tree.rb'

# array_of_numbers = [3, 4, 5]
array_of_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].uniq.sort

random_sorted = array_of_numbers.sort.uniq
new_tree = Tree.new(random_sorted)


# random_numbers = []
# 50.times do
#   random_numbers << rand(10000)
# end
# random_sorted = random_numbers.sort.uniq
# new_tree = Tree.new(random_sorted)


# p new_tree
# p new_tree
# p new_tree

puts
puts
puts

# new_tree.insert(3)
# new_tree.insert(4)
# new_tree.insert(2)
# new_tree.insert(4.5)
# new_tree.insert(4.6)
# new_tree.insert(4.55)

# new_tree.insert(6)
# new_tree.insert(7)
# new_tree.insert(8)
# new_tree.insert(5.5)

puts new_tree.pretty_print

puts
puts
puts

# new_tree.delete(4)

# puts
# puts
# puts

# puts new_tree.pretty_print
