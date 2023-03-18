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

# p 'level_order_recursive'
# p new_tree.level_order_recursive
# puts

# p 'level_order_loop'
# p new_tree.level_order_loop
# puts

# p 'preorder_recursive'
# p new_tree.preorder_recursive
# puts

# p 'preorder_loop'
# p new_tree.preorder_loop
# puts

# p 'inorder_recursive'
# p new_tree.inorder_recursive
# puts

# p 'inorder_loop'
# p new_tree.inorder_loop
# puts

# p 'inorder_loop_2'
# p new_tree.inorder_loop2
# puts

# p 'postorder_recursive'
# p new_tree.postorder_recursive
# puts

new_tree.pretty_print
puts
