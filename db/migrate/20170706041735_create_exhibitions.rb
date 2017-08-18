class CreateExhibitions < ActiveRecord::Migration
  def change
    create_table :exhibitions do |t|
      t.text :title
      t.text :imageAddress
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.float :latitude, :null => false
      t.float :longitude, :null => false
      t.string :spot
      t.string :spot_ascii
      t.string :time
      t.string :callCenter
      t.string :price
      t.integer :impressions_count
      t.timestamps null: false
      t.string :hashtag
      t.boolean :ing
    end
  end
end
