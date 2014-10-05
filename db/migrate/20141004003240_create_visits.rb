class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :place, index: true
      t.string :date
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
