# GneGraph
* Simple Library for defining graphs (consisting of subgraphs, nodes and edges) in DSL-Syntax

## Installation
* Put the following in your Gemfile:

		gem 'gnegraph', :git => 'https://github.com/rostchri/gnegraph.git'
	
## Usage
* Example for defining graphs in DSL-Syntax:

		include GneGraph
		g = graph :title => "Graph 1" do 
			node :title => "Node 1", :mysetting1 => 1 
			node :title => "Node 2", :mysetting2 => 2 
			node :title => "Node 3", :mysetting3 => 2
			graph :title => "Subgraph of Graph 1", :mysettingX => "X"  do 
				node :title => "Node 10", :mysetting10 => 10
				node :title => "Node 20", :mysetting20 => 20
				node :title => "Node 30", :mysetting30 => 30
			end
		end
		puts g.to_s(:include_children => true)
  