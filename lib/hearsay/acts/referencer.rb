module Hearsay
  module Acts
    module Referencer
      def self.included(base)
        base.extend ClassMethods
      end
    
      module ClassMethods
        def references(source_name, options = {})
          send(:include, Hearsay::Acts::Referencer::InstanceMethods) unless self.included_modules.include?(Hearsay::Acts::Referencer::InstanceMethods)
          
          attribute_name = options.delete(:method)
          raise ArgumentError, ":method option is required for references" if attribute_name.blank?
          
          association_name = "#{source_name.to_s.singularize}_references".to_sym
          
          class_eval do
            has_many(association_name,
              :as => :referencer,
              :class_name => 'Reference',
              :conditions => {:attribute_name => attribute_name},
              :dependent => :destroy) unless self.respond_to?(association_name)

            has_many source_name,
              :through => association_name,
              :source => :referenceable,
              :source_type => (options[:class_name] || source_name.to_s.classify)

            before_save proc { self.send(:create_references, source_name, attribute_name, options) }
          end
        end
      end
    
      module InstanceMethods
        private
        def create_references(source_name, attribute_name, options)
          matcher = options[:matcher] || /#([0-9]+)/i
          finder = options[:finder] || :find_by_number
          class_name = options[:class_name] || source_name.to_s.classify
          source_class = class_name.constantize
          collection = options[:collection] || source_class

          collection = collection.call(self) if collection.is_a?(Proc)

          text = self.send(attribute_name)

          object_ids_setter = "#{source_name.to_s.singularize}_ids="

          oids = []
          if text =~ matcher
            matches = text.scan(matcher)
            matches.each do |match|
              if object = collection.send(finder, match)
                oids.push(object.id)
              end
            end
          end
          self.send(object_ids_setter, oids)
        end
      end
    end
  end
end