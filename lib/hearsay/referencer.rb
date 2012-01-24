module Hearsay
  module Referencer
    def self.included(base)
      base.extend ClassMethods
    end
  
    module ClassMethods
      # Public: Set up referenceable assocations
      #
      # source_name  - The name of the source association (model being referenced)
      # options - Options hash (default: {}):
      #           :method     - Name of model attribute containing text references (required)
      #           :matcher    - Regular expression to match on (default: /#([0-9]+)/i)
      #           :finder     - The method used to find referenced objects (default: :find_by_id)
      #           :class_name - The class of the source association, if the name can't be inferred from
      #                         the association name (optional)
      #           :collection - A class or a proc that referenceable objects are scoped to (optional)
      #           
      #
      # Examples
      #
      #   references :issues, :method => :summary, :matcher => /#([0-9]+)/i, :finder => :find_by_number
      #   references :referenced_users,
      #     :method => :body,
      #     :class_name => 'User',
      #     :matcher => /@(\w)/i,
      #     :finder => :find_by_username
      #
      # Returns nothing.
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
      
      # Private: Create reference objects
      #
      # source_name  - The name of the source association (model being referenced)
      # attribute_name - The attribute containing references
      # options - Options hash (see Referencer::ClassMethods.references for details)
      #
      # Examples
      #
      #   create_references(:referenced_users, :body, :class_name => 'User')
      #   # => true
      #
      # Returns true or false
      def create_references(source_name, attribute_name, options)
        matcher = options[:matcher] || /#([0-9]+)/i
        finder = options[:finder] || :find_by_id
        class_name = options[:class_name] || source_name.to_s.classify
        class_name = class_name.constantize
        collection = options[:collection] || class_name

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