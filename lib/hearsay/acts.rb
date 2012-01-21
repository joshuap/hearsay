require 'hearsay/acts/referenceable'
require 'hearsay/acts/referencer'

ActiveRecord::Base.send(:include, Hearsay::Acts::Referenceable)
ActiveRecord::Base.send(:include, Hearsay::Acts::Referencer)