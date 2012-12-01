require 'graphviz'

module GneGraph
  module Representation
    module Graphiz
      
      def plot(mygraph)
        # initialize new Graphviz graph
        GraphViz.digraph(:G) do |graph|
          # TODO: global config for graph
          graph[:truecolor => true,  :rankdir => "TB" ]
          # set global node options for the graph
          GneGraph::Representation::Graphiz::node.config.each { |var,value| graph.node[var.to_sym] = value }
          # set global edge options for the graph
          GneGraph::Representation::Graphiz::edge.config.each { |var,value| graph.edge[var.to_sym] = value }
          graphiz_nodes_and_edges(graph,mygraph)
          graph.output(:png => "test.png")
        end
      end
      
      
      def graphiz_nodes_and_edges(graph,mygraph)
        mygraph.nodes.each do |id,mynode|
          if mynode.is_a? GneGraph::Node # normal node
            mynode.set :representation => graph.add_nodes(mynode.title,mynode.options)
          elsif mynode.is_a? GneGraph::Graph # node is a subgraph
            subgraph = graph.subgraph
            # TODO: global config for subgraphs
            subgraph[:rank => "same"]
            graphiz_nodes_and_edges(subgraph,mynode)
          end
        end
        mygraph.edges.each do |id,myedge|
          myedge.set :representation => graph.add_edges(myedge.source.representation, myedge.target.representation, myedge.options)
        end
      end
      
    end
  end
end