module Hearsay
  module Acts
    module Referenceable
      def self.included(base) 
        base.extend ClassMethods
      end 

      module ClassMethods
        def referenced_by(source_name, options = {})
          send(:include, Hearsay::Acts::Referenceable::InstanceMethods) unless self.included_modules.include?(Hearsay::Acts::Referenceable::InstanceMethods)
          
          class_eval do
            has_many(:referenceable_referencers, :as => :referenceable, :class_name => 'Reference', :dependent => :destroy) unless self.respond_to?(:referenceable_referencers)
            has_many source_name, :through => :referenceable_referencers, :source => :referencer, :source_type => (options[:class_name] || source_name.to_s.classify)
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