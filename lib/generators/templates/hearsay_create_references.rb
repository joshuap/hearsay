class HearsayCreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.references :referencer, :polymorphic => true
      t.references :referenceable, :polymorphic => true
      
      t.timestamps
    end
    add_index :references, [:referencer_id, :referencer_type]
    add_index :references, [:referenceable_id, :referenceable_type]
  end
end