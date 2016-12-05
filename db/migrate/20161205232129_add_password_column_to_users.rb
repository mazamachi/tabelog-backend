class AddPasswordColumnToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.index :id
      t.string :password
    end
    add_index :users, [:name, :password]
  end
end
