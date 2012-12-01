module GneGraph
  
  class Graph < UniversalBlockItem
    attr_accessor :title, :parent, :nodes, :edges, :representation
  
    def initialize(options={},&block)
      # set some default options
      # options = options.reverse_merge :show  => false
      # set some instance-variables according to option-values
      set :title  => options.delete(:title),
          :parent => options.delete(:parent),
          :nodes  => {},
          :edges  => {}
      super
    end

    def edge(id)
      res = edges[id]
      puts "### WARNING: No edge with id ##{id} found" if res.nil?
      res
    end
    
    def node(id)
      res = nodes[id]
      puts "### WARNING: No node with id ##{id} found" if res.nil?
      res
    end
    
    def graph(id)
      res = nodes[id]
      puts "### WARNING: No graph with id ##{id} found" if res.nil?
      res
    end
  
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
  
  
  def self.test
    node1=nil
    g = graph :title => "Graph 1" do
      node1 = add_node :id => 1, :title => "Node 1"
      node2 = add_node :id => 2, :title => "Node 2"
      add_edge :source => node1, :target => node2, :title => "my edge", :weight => 2
      add_edge do 
        set :source => add_node(:id => 3, :title => "Node 3")
        set :target => add_node(:id => 4, :title => "Node 4")
      end
      add_graph :title => "Subgraph of Graph 1", :mysettingX => "X"  do 
        node10 = add_node :title => "Node 10", :shape => "polygon"
        node20 = add_node :title => "Node 20", :shape => "polygon"
        node30 = add_node :title => "Node 30", :shape => "polygon"
        add_edge :source => node10, :target => node20, :style => "dashed", :weight => 5
      end
    end
    puts g.to_s(:include_children => true)
    puts node1
    g
  end
  
end