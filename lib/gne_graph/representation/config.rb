require 'active_support/configurable'

module GneGraph
  module Representation
    module Graphiz
      
      module Node
        class Configuration
          include ActiveSupport::Configurable
          config_accessor :color, :style, :penwidth, :fontname, :fontsize, :fillcolor, :fontcolor, :margin
        end
      end

      module Edge
        class Configuration
          include ActiveSupport::Configurable
          config_accessor :color, :weight, :penwidth, :fontname, :fontsize, :fillcolor, :fontcolor, :dir, :labelfloat, :arrowsize
        end
      end
      
      def self.nodeconfigure(&block)
         yield @nodeconfig ||= GneGraph::Representation::Graphiz::Node::Configuration.new
      end

      def self.edgeconfigure(&block)
         yield @edgeconfig ||= GneGraph::Representation::Graphiz::Edge::Configuration.new
      end
      
      def self.node
        @nodeconfig
      end
      
      def self.edge
        @edgeconfig
      end

      nodeconfigure do |config|
        config.color      = "#ddaa66"
        config.style      = "filled"
        config.penwidth   = "1"
        config.fontname   = "Trebuchet MS"
        config.fontsize   = "8"
        config.fillcolor  = "#ffeecc"
        config.fontcolor  = "#775500"
        config.margin     = "0.1"
      end
      
      edgeconfigure do |config|
        config.color      = "#999999"
        config.weight     = "1"
        config.penwidth   = "1"
        config.fontname   = "Verdana"
        config.fontsize   = "6"
        config.dir        = "none"
        config.fontcolor  = "#444444"
        config.arrowsize  = "0.5"
        config.labelfloat = "false"
      end

    end
  end
end
    
