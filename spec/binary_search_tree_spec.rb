#spec/binary_search_tree_spec.rb
require './binary_search_tree'

describe Node do
  describe 'new_node' do
    it 'makes a new node' do
      new_node = Node.new(2)
      expect(new_node.data).to be == 2
    end
  end
end

describe Tree do
  before(:each) do
    @new_tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  end

  describe 'new tree' do
    it 'checks to make sure that the new tree is balanced' do
      expect(@new_tree.root.data).to be == 5
      expect(@new_tree.root.left.data).to be == 2
      expect(@new_tree.root.left.left.data).to be == 1
      expect(@new_tree.root.left.right.data).to be == 3
      expect(@new_tree.root.left.right.right.data).to be == 4
      expect(@new_tree.root.left.data).to be == 2
      expect(@new_tree.root.right.data).to be == 8
      expect(@new_tree.root.right.left.data).to be == 6
      expect(@new_tree.root.right.left.right.data).to be == 7
      expect(@new_tree.root.right.right.data).to be == 9
      expect(@new_tree.root.right.right.right.data).to be == 10
    end
  end

  describe 'checks Find method' do
    it 'checks various Find commands' do
      expect(@new_tree.find(4)).to be == '4 is in the tree'
      expect(@new_tree.find(4.5)).to be == '4.5 is not in the tree'
      expect(@new_tree.find('j')).to be == "'j' is invalid"
    end
  end

  describe 'checks Insert method' do
    it 'inserts some elements and checks that they are correctly handled' do
      @new_tree.insert(99)
      expect(@new_tree.find(99)).to be == '99 is in the tree'
      expect(@new_tree.root.right.right.right.right.data).to be == 99
      @new_tree.insert(89)
      expect(@new_tree.find(89)).to be == '89 is in the tree'
      expect(@new_tree.root.right.right.right.right.left.data).to be == 89
      @new_tree.insert(2.5)
      expect(@new_tree.find(2.5)).to be == '2.5 is in the tree'
      expect(@new_tree.root.left.right.left.data).to be_within(0.001).of(2.5)
      @new_tree.insert(-22)
      expect(@new_tree.find(-22)).to be == '-22 is in the tree'
      expect(@new_tree.root.left.left.left.data).to be == -22
      expect(@new_tree.insert('j')).to be == "'j' is invalid"
      # 3.times { puts }
      # puts @new_tree.pretty_print
    end
  end
end

describe Tree do
  describe 'checks insert method works with empty tree' do
    it 'creates a new empty tree, inserts a node & checks it' do
      @empty_tree = Tree.new
      expect(@empty_tree.root.data).to be nil
      @empty_tree.insert(101)
      expect(@empty_tree.root.data).to be == 101
      expect(@empty_tree.root.left).to be nil
      expect(@empty_tree.root.right).to be nil
    end
  end
end

describe Tree do
  describe 'checks Delete method on the root node with no children' do
    it 'creates and checks deleting the root with no children' do
      # 4.times { puts }
      @tree = Tree.new
      @tree.insert(5)
      expect(@tree.root.data).to be 5
      # @tree.pretty_print
      # 3.times { puts }
      @tree.delete(5)
      expect(@tree.root.data).to be nil
      expect(@tree.root.left).to be nil
      expect(@tree.root.right).to be nil
      # @tree.pretty_print
    end
  end
end

describe Tree do
  describe 'checks Delete method on the root with a left child' do
    it 'creates a root with a left child and moves the left child up to root' do
      # 4.times { puts }
      @tree = Tree.new
      @tree.insert(5)
      @tree.insert(3)
      @tree.insert(4)
      @tree.insert(2)
      expect(@tree.root.data).to be 5
      expect(@tree.root.left.data).to be 3
      # @tree.pretty_print
      # 4.times { puts }
      @tree.delete(5)
      expect(@tree.root.data).to be 3
      expect(@tree.root.left.data).to be 2
      expect(@tree.root.right.data).to be 4
      # @tree.pretty_print
    end
  end
end

describe Tree do
  describe 'checks Delete method on the root with a right child' do
    it 'creates a root with a right child and moves the right child up to root' do
      # 4.times { puts }
      @tree = Tree.new
      @tree.insert(5)
      @tree.insert(7)
      @tree.insert(6)
      @tree.insert(8)
      expect(@tree.root.data).to be 5
      expect(@tree.root.right.data).to be 7
      # @tree.pretty_print
      # 4.times { puts }
      @tree.delete(5)
      expect(@tree.root.data).to be 7
      expect(@tree.root.left.data).to be 6
      expect(@tree.root.right.data).to be 8
      # @tree.pretty_print
    end
  end
end

describe Tree do
  describe 'checks Delete method on the root with 2 children' do
    it 'creates a tree with 10 elements, deletes the root & moves the next highest node to root' do
      # 4.times { puts }
      @tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      # @tree.pretty_print
      expect(@tree.root.data).to be 5
      # 4.times { puts }
      @tree.delete(5)
      expect(@tree.root.data).to be 6
      # 4.times { puts }
      # @tree.pretty_print
    end
  end
end

describe Tree do
  describe 'checks the Delete method on leaf nodes' do
    it 'creates a tree with 10 elements and deletes leaf nodes' do
      # 4.times { puts }
      @tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      # @tree.pretty_print
      @tree.delete(10)
      # @tree.pretty_print
      @tree.delete(9)
      # @tree.pretty_print
      @tree.delete(1)
      # @tree.pretty_print
      @tree.delete(7)
      # @tree.pretty_print
      @tree.delete(6)
      # @tree.pretty_print
      @tree.delete(8)
      # @tree.pretty_print
      @tree.delete(4)
      # @tree.pretty_print
      @tree.delete(3)
      # @tree.pretty_print
      @tree.delete(2)
      # 4.times { puts }
      # @tree.pretty_print
      expect(@tree.root.data).to be 5
      expect(@tree.root.left).to be nil
      expect(@tree.root.right).to be nil
    end
  end
end

describe Tree do
  describe 'checks the Delete method on nodes with one child' do
    it 'creates a tree and deletes nodes with one child' do
      # 4.times { puts }
      @tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      # @tree.pretty_print
      @tree.delete(9)
      @tree.delete(6)
      @tree.delete(3)
      expect(@tree.root.right.data).to be 8
      expect(@tree.root.right.right.data).to be 10
      expect(@tree.root.right.left.data).to be 7
      expect(@tree.root.left.data).to be 2
      expect(@tree.root.left.right.data).to be 4
      expect(@tree.root.left.left.data).to be 1
      @tree.insert(0.5)
      @tree.delete(1)
      expect(@tree.root.left.left.data).to be 0.5
      # 4.times { puts }
      # @tree.pretty_print
    end
  end
end

describe Tree do
  describe 'checks the Delete method' do
    it 'creates a large tree and deletes nodes with all different attributes correctly' do

      array = []
      30.times { |num = 1| array << num }

      @tree = Tree.new(array)

      # delete lower half of the array to see the results in pretty print better
      array_to_delete = [13, 11, 9, 7, 5, 3, 1, 12, 8, 4, 0, 10, 2]
      array_to_delete.each { |num| @tree.delete(num) }

      # delete node 22 that has 2 children with 2 children with 2 children
      # and moves node 23 which is a leaf node
      expect(@tree.root.right.data).to be 22
      # 4.times { puts }
      # @tree.pretty_print
      # p 'starting to delete 22'
      @tree.delete(22)
      expect(@tree.root.right.data).to be 23
      # @tree.pretty_print

      # delete node 23 that has 2 children with 2 children
      # and moves node 24 that has a right child
      # 4.times { puts }
      # p 'starting to delete 23'
      @tree.delete(23)
      # @tree.pretty_print
      expect(@tree.root.right.data).to be 24

      # delete node 24 that has 2 children
      # and moves node 25 that has no children
      # 4.times { puts }
      # p 'starting to delete 24'
      @tree.delete(24)
      # @tree.pretty_print
      expect(@tree.root.right.data).to be 25

      # delete node 25 that has 2 children
      # and moves node 26 that has 1 right child
      # 4.times { puts }
      # p 'starting to delete 25'
      @tree.delete(25)
      # @tree.pretty_print
      expect(@tree.root.right.data).to be 26

      # delete node 26 that has 2 children
      # and moves node 27 that has no children
      # 4.times { puts }
      # p 'starting to delete 26'
      @tree.delete(26)
      # @tree.pretty_print
      expect(@tree.root.right.data).to be 27

      # delete node 27 that has 1 right child
      # and moves node 28 that has 1 right child
      # 4.times { puts }
      # p 'starting to delete 27'
      @tree.delete(27)
      # @tree.pretty_print
      expect(@tree.root.right.data).to be 28

      # delete node 28 that has 1 right child
      # and moves node 29 that has no children
      # 4.times { puts }
      # p 'starting to delete 28'
      @tree.delete(28)
      # @tree.pretty_print
      expect(@tree.root.right.data).to be 29

      # delete node 18 that has 1 right child
      # and moves node 19 that has 0 children
      # 4.times { puts }
      # p 'starting to delete 18'
      @tree.delete(18)
      # @tree.pretty_print
      expect(@tree.root.right.left.data).to be 19

      # delete node 19 that has 1 right child
      # and moves node 20 that has 0 children
      # 4.times { puts }
      # p 'starting to delete 19'
      @tree.delete(19)
      # @tree.pretty_print
      expect(@tree.root.right.left.data).to be 20

      # delete node 20 that has 1 right child
      # and moves node 21 that has 0 children
      # 4.times { puts }
      # p 'starting to delete 20'
      @tree.delete(20)
      # @tree.pretty_print
      expect(@tree.root.right.left.data).to be 21

      # delete node 21 that has 1 right child
      # and moves node 16 that has 0 children
      # 4.times { puts }
      # p 'starting to delete 21'
      @tree.delete(21)
      # @tree.pretty_print
      expect(@tree.root.right.left.data).to be 16

      # delete node 29 that has 1 right child
      # and moves node 16 that has 2 children
      # 4.times { puts }
      # p 'starting to delete 29'
      @tree.delete(29)
      # @tree.pretty_print
      expect(@tree.root.right.data).to be 16

      # delete node 14 that has 2 children
      # and moves node 15 that has 0 children
      # 4.times { puts }
      # p 'starting to delete 14'
      @tree.delete(14)
      # @tree.pretty_print
      expect(@tree.root.data).to be 15

      # delete node 15 that is root & has 2 children
      # and moves node 16 that has 1 right child
      # 4.times { puts }
      # p 'starting to delete 15'
      @tree.delete(15)
      # @tree.pretty_print
      expect(@tree.root.data).to be 16

      # delete node 16 that is root & has 2 children
      # and moves node 17 that has no children
      # 4.times { puts }
      # p 'starting to delete 16'
      @tree.delete(16)
      # @tree.pretty_print
      expect(@tree.root.data).to be 17

      # delete node 17 that is root & has 1 left child
      # and moves node 6 that has no children
      # 4.times { puts }
      # p 'starting to delete 17'
      @tree.delete(17)
      # @tree.pretty_print
      expect(@tree.root.data).to be 6

      # delete node 16 that is root & has no children
      # and points root at nil
      # 4.times { puts }
      # p 'starting to delete 6'
      @tree.delete(6)
      # @tree.pretty_print
      expect(@tree.root.data).to be nil
    end
  end
end

describe Tree do
  describe 'checks the Delete method on non root nodes that have 2 children' do
    it 'creates a tree and deletes nodes with 2 children correctly' do
      # 4.times { puts }
      array = []
      12.times { |num = 1| array << num }
      @tree = Tree.new(array)
      # @tree.pretty_print
      @tree.delete(10)

      # @tree.pretty_print
    end
  end
end

describe Tree do
  describe 'Checks the delete method deleting root node' do
    it 'deletes root node multiple ways' do

      tree = Tree.new
      # tree.pretty_print

      tree.insert(10)
      # 4.times { puts }
      # tree.pretty_print
      expect(tree.root.data).to be 10

      # delete root node with no children
      tree.delete(10)
      # 4.times { puts }
      # tree.pretty_print
      expect(tree.root.data).to be nil

      tree.insert(10)
      tree.insert(9)
      tree.insert(11)
      # 4.times { puts }
      # tree.pretty_print
      expect(tree.root.data).to be 10
      expect(tree.root.left.data).to be 9
      expect(tree.root.right.data).to be 11


      # delete root node with 2 children that have no children
      tree.delete(10)
      # 4.times { puts }
      # tree.pretty_print
      expect(tree.root.data).to be 11

      # delete root node with a left child that has no children
      tree.delete(11)
      # 4.times { puts }
      # tree.pretty_print
      expect(tree.root.data).to be 9

      # delete root node with a right child that has no children
      tree.insert(10)
      # 4.times { puts }
      # tree.pretty_print
      expect(tree.root.right.data).to be 10
      tree.delete(9)
      # 4.times { puts }
      # tree.pretty_print
      expect(tree.root.data).to be 10

      # delete root node with a left child that has 2 children
      tree.insert(8)
      tree.insert(9)
      tree.insert(7)
      # 4.times { puts }
      # tree.pretty_print
      expect(tree.root.data).to be 10
      expect(tree.root.left.data).to be 8
      expect(tree.root.left.right.data).to be 9
      expect(tree.root.left.left.data).to be 7
      tree.delete(10)
      # 4.times { puts }
      # tree.pretty_print

      tree.delete(9)
      tree.insert(6)
      expect(tree.root.data).to be 8
      expect(tree.root.left.data).to be 7
      expect(tree.root.left.left.data).to be 6
      # 4.times { puts }
      # tree.pretty_print

      # delete root node with a left child that has a left child
      tree.delete(8)
      expect(tree.root.data).to be 7
      expect(tree.root.left.data).to be 6
      # 4.times { puts }
      # tree.pretty_print

      tree.insert(6.5)
      expect(tree.root.data).to be 7
      expect(tree.root.left.data).to be 6
      expect(tree.root.left.right.data).to be 6.5
      # 4.times { puts }
      # tree.pretty_print

      # delete root node with a left child that has a right child
      tree.delete(7)
      expect(tree.root.data).to be 6
      expect(tree.root.right.data).to be 6.5
      # 4.times { puts }
      # tree.pretty_print

      # delete root node with a right child that has 2 children
      tree.delete(6.5)
      tree.insert(8)
      tree.insert(8)
      tree.insert(9)
      tree.insert(7)
      # 4.times { puts }
      # tree.pretty_print
      tree.delete(6)
      expect(tree.root.data).to be 8
      expect(tree.root.right.data).to be 9
      # 4.times { puts }
      # tree.pretty_print

      # delete root node with a right child that has a left child
      tree.delete(7)
      tree.insert(8.5)
      # 4.times { puts }
      # tree.pretty_print
      tree.delete(8)
      expect(tree.root.data).to be 9
      expect(tree.root.left.data).to be 8.5
      expect(tree.root.right).to be nil
      # 4.times { puts }
      # tree.pretty_print

      # # setup next tests
      array = []
      7.times { |num| array << num }
      # 4.times { puts }
      tree = Tree.new(array)
      # tree.pretty_print

      # delete root node with 2 children - both have 2 children
      tree.delete(3)
      # 4.times { puts }
      # tree.pretty_print
      expect(tree.root.data).to be 4
      expect(tree.root.right.data).to be 5
      expect(tree.root.right.right.data).to be 6
      expect(tree.root.right.left).to be nil

      tree.delete(4)
      expect(tree.root.data).to be 5
      tree.delete(5)
      expect(tree.root.data).to be 6
      tree.delete(6)
      expect(tree.root.data).to be 1
      # 4.times { puts }
      # tree.pretty_print
    end
  end
end

describe Tree do
  describe 'Checks the delete method deleting non root nodes' do
    it 'deletes non root node multiple ways' do
      array = []
      63.times { |num| array << num }
      tree = Tree.new(array)
      # 4.times { puts }
      # tree.pretty_print

      # deletes leaf node both sides

      expect(tree.root.left.right.right.right.left.data).to be 28
      tree.delete(28)
      expect(tree.root.left.right.right.right.left).to be nil
      # tree.pretty_print
      # expect(tree.root.left.right.right.left.right).to be 26
      tree.root.left.right.right.left.right.data
      expect(tree.root.left.right.right.left.right.data).to be 26
      tree.delete(26)
      expect(tree.root.left.right.right.left.right).to be nil
      # tree.pretty_print

      # deletes node woth 2 leaf nodes
      expect(tree.root.left.right.left.right.data).to be 21
      tree.delete(21)
      expect(tree.root.left.right.left.right.data).to be 22
      # tree.pretty_print
      tree.delete(22)
      expect(tree.root.left.right.left.right.data).to be 20
      # tree.pretty_print

      expect(tree.root.left.right.left.left.data).to be 17
      tree.delete(17)
      expect(tree.root.left.right.left.left.data).to be 18
      # tree.pretty_print
      expect(tree.root.left.right.left.right.data).to be 20
      tree.delete(19)
      expect(tree.root.left.right.left.data).to be 20
      expect(tree.root.left.right.left.right).to be nil
      # tree.pretty_print

      expect(tree.root.right.data).to be 47
      tree.delete(47)
      expect(tree.root.right.data).to be 48
      # tree.pretty_print
    end
  end
end

describe Tree do
  before(:each) do
    array = []
    15.times { |num| array << num }
    @tree = Tree.new(array)
  end
  describe 'checks the Level Order method' do
    it 'checks the level order traversal' do
      expect(@tree.root.data).to be == 7
      expect(@tree.root.left.left.right.data).to be == 2
      expect(@tree.root.right.left.right.data).to be == 10
    end
    it 'checks an array of all the values in level order from Root' do
      expect(@tree.level_order).to be == [7, 3, 11, 1, 5, 9, 13, 0, 2, 4, 6, 8, 10, 12, 14]
    end
    it 'checks an array of all the values in level order from node 3' do
      start_node = @tree.root.left
      expect(@tree.level_order(start_node)).to be == [3, 1, 5, 0, 2, 4, 6]
    end
    it 'checks the inorder method' do
      expect(@tree.inorder).to be == [0, 1, 2, 3, 4, 5, 6, 7, 8 ,9, 10, 11, 12, 13, 14]
    end
    it 'check the inorder method from node 11' do
      start_node = @tree.root.right
      expect(@tree.inorder(start_node)).to be == [8, 9, 10, 11, 12, 13, 14]
    end
    it 'checks the preorder method' do
      expect(@tree.preorder).to be == [7, 3, 1, 0, 2, 5, 4, 6, 11, 9, 8, 10, 13, 12, 14]
    end
    it 'checks the preorder method from node 11' do
      start_node = @tree.root.right
      expect(@tree.preorder(start_node)).to be == [11, 9, 8, 10, 13, 12, 14]
    end
    it 'checks the postorder method' do
      expect(@tree.postorder).to be == [0, 2, 1, 4, 6, 5, 3, 8, 10, 9, 12, 14, 13, 11, 7]
    end
    it '' do
      start_node = @tree.root.right
      expect(@tree.postorder(start_node)).to be == [8, 10, 9, 12, 14, 13, 11]
    end
  end
end

describe 'checks height method' do
  before(:each) do
    array = []
    15.times { |num| array << num }
    @tree = Tree.new(array)
  end

  describe 'tests the height of different nodes' do
    it 'tests the height of root' do
      expect(@tree.height).to be == 3
    end
    it 'tests the height of node 11' do
      start_node = 11
      expect(@tree.height(start_node)).to be == 2
    end
    it 'tests the height of node 5' do
      start_node = 5
      expect(@tree.height(start_node)).to be == 1
    end
    it 'tests the height of node 12' do
      start_node = 12
      expect(@tree.height(start_node)).to be == 0
    end
  end
end

describe 'tests the depth of different nodes' do
  before(:each) do
    array = []
    15.times { |num| array << num }
    @tree = Tree.new(array)
  end

  describe 'tests the depth of different nodes' do
    it 'tests the depth of the root node' do
      expect(@tree.depth).to be == 0
    end
    it 'tests the depth of node 14' do
      expect(@tree.depth(14)).to be == 3
    end
    it 'tests the depth of node 5' do
      expect(@tree.depth(5)).to be == 2
    end
    it 'tests the depth of node 11' do
      expect(@tree.depth(11)).to be == 1
    end
    it 'tests the output of a node that is not in the tree' do
      expect(@tree.depth(99)).to be == '99 is not in the tree'
    end
  end
end

# describe Tree do
#   describe '' do
#     it '' do
#     end
#   end
# end

# describe Tree do
#   describe '' do
#     it '' do
#     end
#   end
# end

# describe Tree do
#   describe '' do
#     it '' do
#     end
#   end
# end

# describe Tree do
#   describe '' do
#     it '' do
#     end
#   end
# end
