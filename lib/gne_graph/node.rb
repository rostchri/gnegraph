module GneGraph
  class Node < DSLBlock::UniversalItem
    attr_accessor :title, :parent, :representation, :goptions
    
    def initialize(options={},&block)
      # set some default options
      options = options.reverse_merge :goptions  => {}
      # set some instance-variables according to option-values
      set :parent    => options.delete(:parent),
          :title     => options.delete(:title),
          :goptions  => options.delete(:goptions)
      super
    end
    
    def to_s(opts={})
      res = "#{self.class.name}: ##{id} title: #{title} depth: #{depth} options: #{options}"
      res
    end
    
    
  end
end