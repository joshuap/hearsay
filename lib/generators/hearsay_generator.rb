class HearsayGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  source_root File.expand_path("../templates", __FILE__)

  def self.next_migration_number(dirname)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_migration_file
    migration_template 'hearsay_create_references.rb', 'db/migrate/hearsay_create_references.rb' unless Reference.table_exists?
  end
end