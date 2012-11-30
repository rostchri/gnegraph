module GneGraph
  class Graph < UniversalBlockItem
    attr_accessor :title, :nodes
  
    def initialize(options={},&block)
      # set some default options
      # options = options.reverse_merge :show  => false
      # set some instance-variables according to option-values
      set :title  => options.delete(:title),
          :nodes  => [] 
      super
    end
  
    def node(options = {}, &block)
      nodes << Node.new(options.merge!({:parent => self}), &block)
      nil
    end
  
    def graph(options={},&block)
      nodes << Graph.new(options.merge!({:parent => self}),&block)
      nil
    end
    
    def to_s(opts={})
      opts = opts.reverse_merge :include_children => false
      res = "#{self.class.name}: ##{id} title: #{title} depth: #{depth} options: #{options}"
      nodes.each { |node| res += "\n#{(depth+1).times.map {"\t"}.join("")}#{node.to_s(opts)}" } if opts[:include_children]
      res
    end
  end
  
  def graph(options={}, &block)
    g = Graph.new(options.merge!({}),&block)
  end
  
end