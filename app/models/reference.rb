class Reference < ActiveRecord::Base
  belongs_to :referenceable, :polymorphic => true
  belongs_to :referencer, :polymorphic => true
end