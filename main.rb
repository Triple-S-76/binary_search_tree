
require './binary_search_tree'

array1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]

random_numbers = []
50.times do
  random_numbers << rand(10000)
end
array2 = random_numbers.sort.uniq

binary_search_tree = Tree.new(array1)
binary_search_tree.pretty_print

# p binary_search_tree.level_order
# p binary_search_tree.inorder
# p binary_search_tree.preorder
# p binary_search_tree.postorder
# p binary_search_tree.height(9)

3.times { puts }
binary_search_tree.pretty_print
3.times { puts }
