class CreateExhibitions < ActiveRecord::Migration
  def change
    create_table :exhibitions do |t|
      t.text :title
      t.text :imageAddress
      t.string :dateStart
      t.string :dateEnd
      t.string :location
      t.float :latitude, :null => false
      t.float :longitude, :null => false
      t.string :spot
      t.string :time
      t.string :callCenter
      t.string :price
      t.integer :impressions_count
      t.timestamps null: false
    end
  end
end
