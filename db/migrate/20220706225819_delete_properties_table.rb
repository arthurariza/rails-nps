class DeletePropertiesTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :properties
  end
end
