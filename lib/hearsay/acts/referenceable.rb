module Hearsay
  module Acts
    module Referenceable
      def self.included(base) 
        base.extend ClassMethods
      end 

      module ClassMethods
        # Public: Set up referencer assocations
        #
        # source_name  - The name of the source association (model referencing object)
        # options - Options hash (default: {}):
        #           :method     - Name of referencer attribute containing text references (required)
        #           :class_name - The class of the source association, if the name can't be inferred from
        #                         the association name (optional)
        #
        # Examples
        #
        #   referenced_by :issues, :method => :summary
        #   referenced_by :referencing_tweets, :method => :body, :class_name => 'Tweet'
        #
        # Returns nothing.
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
    end
  end
end