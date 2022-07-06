class CreateNps < ActiveRecord::Migration[6.1]
  def change
    create_table :nps do |t|
      t.integer :score
      t.integer :touchpoint
      t.string :respondent_class
      t.references :respondent, null: false, foreign_key: { to_table: 'users' }
      t.string :object_class
      t.references :object, null: false, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
