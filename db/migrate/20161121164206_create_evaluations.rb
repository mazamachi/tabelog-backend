class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.references :photo, null: false
      t.references :user, null: false
      t.integer :score, null: false
      t.timestamps
    end
    add_index :evaluations, [:photo_id, :user_id] , unique: true
  end
end
