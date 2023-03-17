# frozen_string_literal: true

require './binary_search_tree_2'

array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
# array = nil

new_tree = Tree.new
new_tree.build_tree(array)

new_tree.pretty_print
puts

new_tree.insert(99)
new_tree.insert(0)
new_tree.insert(1.5)
puts

new_tree.find(7)
puts

p new_tree.level_order_recursive
puts

p new_tree.level_order_loop
puts


new_tree.pretty_print
puts
