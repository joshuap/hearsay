require 'hearsay/referenceable'
require 'hearsay/referencer'
require 'hearsay/engine'

ActiveRecord::Base.send(:include, Hearsay::Referenceable)
ActiveRecord::Base.send(:include, Hearsay::Referencer)