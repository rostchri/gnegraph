require 'graphviz'

module GneGraph
  module Representation
    module Graphiz
      
      def plot(mygraph,filename)
        # initialize new Graphviz graph
        GraphViz.digraph(:G,GneGraph::Representation::Graphiz::graph.config.merge(mygraph.goptions)) do |graph|
          # set global node config
          GneGraph::Representation::Graphiz::node.config.each { |var,value| graph.node[var.to_sym] = value }
          # set global edge config
          GneGraph::Representation::Graphiz::edge.config.each { |var,value| graph.edge[var.to_sym] = value }
          graphiz_nodes_and_edges(graph,mygraph)
          graph.output(:png => filename)
        end
      end
      
      def graphiz_nodes_and_edges(graph,mygraph)
        mygraph.nodes.each do |id,mynode|
          if mynode.is_a? GneGraph::Node # normal node
            mynode.set :representation => graph.add_nodes(mynode.title,mynode.goptions)
          elsif mynode.is_a? GneGraph::Graph # node is a subgraph
            subgraph = graph.subgraph(GneGraph::Representation::Graphiz::subgraph.config.merge(mynode.goptions))
            graphiz_nodes_and_edges(subgraph,mynode)
          end
        end
        mygraph.edges.each do |id,myedge|
          myedge.set :representation => graph.add_edges(myedge.source.representation, myedge.target.representation, myedge.goptions)
        end
      end
      
    end
  end
end