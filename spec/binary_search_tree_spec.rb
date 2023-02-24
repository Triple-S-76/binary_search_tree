#spec/binary_search_tree_spec.rb
require './binary_search_tree.rb'

describe Node do
  describe "new_node" do
    it "makes a new node" do
      new_node = Node.new(2)
      expect(new_node.data).to be == 2
    end
  end
end
