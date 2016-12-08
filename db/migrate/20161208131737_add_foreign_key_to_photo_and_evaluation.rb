class AddForeignKeyToPhotoAndEvaluation < ActiveRecord::Migration
  def change
		add_foreign_key :photos, :users
		add_foreign_key :evaluations, :photos
		add_foreign_key :evaluations, :users
  end
end
