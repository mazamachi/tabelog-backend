class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :shop, null: false
      t.string :url, null:false
      t.timestamps
    end
  end
end
