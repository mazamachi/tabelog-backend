class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations, id: false, primary_key: [:photo_id, :user_id] do |t|
      t.references :photo, null: false
      t.references :user, null: false
      t.integer :score, null: false
      t.timestamps
    end
  end
end
