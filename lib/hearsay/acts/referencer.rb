module Hearsay
  module Acts
    module Referencer
      def self.included(base)
        base.extend ClassMethods
      end
    
      module ClassMethods
        def references(source_name, options = {})
          send(:include, Hearsay::Acts::Referencer::InstanceMethods) unless self.included_modules.include?(Hearsay::Acts::Referencer::InstanceMethods)
      
          class_eval do
            has_many(:referenceable_references, :as => :referencer, :class_name => 'Reference', :dependent => :destroy) unless self.respond_to?(:referenceable_references)
            has_many source_name, :through => :referenceable_references, :source => :referenceable, :source_type => (options[:class_name] || source_name.to_s.classify)
            before_save proc { self.send(:create_references, source_name, options) }
          end
        end
      end
    
      module InstanceMethods
        private
        def create_references(source_name, options)
          matcher = options[:matcher] || /#([0-9]+)/i
          method = options[:method] || :body
          finder = options[:finder] || :find_by_number
          class_name = options[:class_name] || source_name.to_s.classify
          source_class = class_name.constantize
          collection = options[:collection] || source_class

          collection = collection.call(self) if collection.is_a?(Proc)

          text = self.send(method)

          object_ids_setter = "#{source_name.to_s.singularize}_ids="

          tids = []
          if text =~ matcher
            matches = text.scan(matcher)
            matches.each do |match|
              if object = collection.send(finder, match)
                tids.push(object.id)
              end
            end
          end
          self.send(object_ids_setter, tids)
        end
      end
    end
  end
end