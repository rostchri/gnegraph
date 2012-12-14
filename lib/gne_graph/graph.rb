module GneGraph
  
  class Graph < DSLBlock::UniversalItem
    attr_accessor :title, :parent, :nodes, :edges, :representation, :goptions
  
    def initialize(options={},&block)
      # set some default options
      options = options.reverse_merge :goptions  => {}
      # set some instance-variables according to option-values
      set :title    => options.delete(:title),
          :parent   => options.delete(:parent),
          :goptions => options.delete(:goptions),
          :nodes    => {},
          :edges    => {}
      super
    end

    # returns edges, nodes and subgraphs by id
    def edge(id)
      res = edges[id]
      #puts "### WARNING: No edge with id ##{id} found" if res.nil?
      res
    end
    
    def node(id)
      res = nodes[id]
      #puts "### WARNING: No node with id ##{id} found" if res.nil?
      res
    end
    
    def graph(id)
      res = nodes[id]
      #puts "### WARNING: No graph with id ##{id} found" if res.nil?
      res
    end
  
    # adding new nodes, graphs or edges
    def add_node(options = {}, &block)
      node = Node.new(options.merge!({:parent => self}), &block)
      nodes[node.id] = node
    end
  
    def add_graph(options={},&block)
      graph = Graph.new(options.merge!({:parent => self}),&block)
      nodes[graph.id] = graph
    end

    def add_edge(options={},&block)
      edge = Edge.new(options.merge!({:parent => self}),&block)
      edges[edge.id] = edge
    end
    
    def to_s(opts={})
      opts = opts.reverse_merge :include_children => false
      res = "#{self.class.name}: ##{id} title: #{title} depth: #{depth} options: #{options}"
      nodes.each { |id,node| res += "\n#{(depth+1).times.map {"\t"}.join("")}#{node.to_s(opts)}" } if opts[:include_children]
      edges.each { |id,edge| res += "\n#{(depth+1).times.map {"\t"}.join("")}#{edge.to_s(opts)}" } if opts[:include_children]
      res
    end
  end
  
  def graph(options={}, &block)
    g = Graph.new(options.merge!({}),&block)
  end
    
end