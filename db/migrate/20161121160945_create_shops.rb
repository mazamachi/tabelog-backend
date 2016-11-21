class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops, id: false, primary_key: :shop_id do |t|
      t.column :shop_id, :integer, null: false
      t.column :name, :string, null: false
      t.column :longitude, :decimal, null: false
      t.column :latitude, :decimal, null: false
      t.timestamps
    end
  end
end
