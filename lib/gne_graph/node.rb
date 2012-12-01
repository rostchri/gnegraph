module GneGraph
  class Node < UniversalBlockItem
    attr_accessor :title, :parent, :representation
    
    def initialize(options={},&block)
      # set some default options
      # options = options.reverse_merge :show  => false
      # set some instance-variables according to option-values
      set :parent    => options.delete(:parent),
          :title     => options.delete(:title)
      super
    end
  end
end