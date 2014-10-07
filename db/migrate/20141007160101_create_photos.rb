class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :visit, index: true
      t.string :picture

      t.timestamps
    end
  end
end
