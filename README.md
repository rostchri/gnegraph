# GneGraph
* Simple Library for defining graphs (consisting of subgraphs, nodes and edges) in DSL-Syntax

## Installation
* Put the following in your Gemfile:

		gem 'gnegraph', :git => 'https://github.com/rostchri/gnegraph.git'
	
## Usage
* Example for defining graphs in DSL-Syntax:

		include GneGraph
		g = graph :title => "Graph 1", :truecolor => false, :rankdir => "BT" do
	    node1 = add_node :id => 1, :title => "Node 1"
	    node2 = add_node :id => 2, :title => "Node 2"
	    add_edge :source => node1, :target => node2, :title => "my edge", :weight => 2
	    add_edge do 
	      set :source => add_node(:id => 3, :title => "Node 3")
	      set :target => add_node(:id => 4, :title => "Node 4")
	    end
	    add_graph :title => "Subgraph of Graph 1" do 
	      node10 = add_node :title => "Node 10", :shape => "polygon"
	      node20 = add_node :title => "Node 20", :shape => "polygon"
	      node30 = add_node :title => "Node 30", :shape => "polygon"
	      add_edge :source => node10, :target => node20, :style => "dashed", :weight => 5
	    end
		end
		puts g.to_s(:include_children => true)
  	# Ploting this graph using graphiz
		include GneGraph::Representation::Graphiz
		plot(g,"test.png")