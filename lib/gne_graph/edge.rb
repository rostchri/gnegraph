module GneGraph
  class Edge < DSLBlock::UniversalItem
    attr_accessor :title, :parent, :source, :target, :representation, :goptions
    
    def initialize(options={},&block)
      # set some default options
      options = options.reverse_merge :goptions  => {}
      # set some instance-variables according to option-values
      set :parent    => options.delete(:parent),
          :source    => options.delete(:source),
          :target    => options.delete(:target),
          :title     => options.delete(:title),
          :goptions  => options.delete(:goptions)
      super
    end
    def node(id)
      parent.node(id)
    end
    def add_node(options = {}, &block)
      if block_given?
        parent.add_node(options,yield)
      else
        parent.add_node options
      end
    end
    def to_s(opts={})
      "#{self.class.name}: ##{id} source: ##{source.id} target: ##{target.id} title: #{title} depth: #{depth} options: #{options}"
    end
  end
end