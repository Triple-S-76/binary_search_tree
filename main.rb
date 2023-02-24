
require './binary_search_tree.rb'

array1 = [1, 2, 3, 4, 5, 6, 7, 8, 9]

random_numbers = []
50.times do
  random_numbers << rand(10000)
end
array2 = random_numbers.sort.uniq

binary_search_tree = Tree.new(array1)

puts
puts
puts
binary_search_tree.pretty_print
puts
puts
puts

binary_search_tree.find(4)
binary_search_tree.find(4.5)
binary_search_tree.find('j')
