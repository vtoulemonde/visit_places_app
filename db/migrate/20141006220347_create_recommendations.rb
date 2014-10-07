class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.references :user, index: true
      t.references :visit, index: true
      t.text :comment

      t.timestamps
    end
  end
end
