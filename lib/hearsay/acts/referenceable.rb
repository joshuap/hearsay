module Hearsay
  module Acts
    module Referenceable
      def self.included(base) 
        base.extend ClassMethods
      end 

      module ClassMethods
        def referenced_by(source_name, options = {})
          send(:include, Hearsay::Acts::Referenceable::InstanceMethods) unless self.included_modules.include?(Hearsay::Acts::Referenceable::InstanceMethods)
          
          attribute_name = options.delete(:method)
          raise ArgumentError, ":method is required for references" if attribute_name.blank?
          
          association_name = "#{source_name.to_s.singularize}_references".to_sym
          
          class_eval do
            has_many(association_name,
              :as => :referenceable,
              :class_name => 'Reference',
              :conditions => {:attribute_name => attribute_name},
              :dependent => :destroy) unless self.respond_to?(association_name)

            has_many source_name,
              :through => association_name,
              :source => :referencer,
              :source_type => (options[:class_name] || source_name.to_s.classify)
          end
        end
      end

      module InstanceMethods
        def self.included(base)
          base.extend ClassMethods
        end

        module ClassMethods; end
      end
    end
  end
end