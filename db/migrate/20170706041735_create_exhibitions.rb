class CreateExhibitions < ActiveRecord::Migration
  def change
    create_table :exhibitions do |t|
      t.text :title
      t.text :imageAddress
      t.string :dateStart
      t.string :dateEnd
      t.string :location
      t.string :spot
      t.string :time
      t.string :callCenter
      t.string :price
      t.timestamps null: false
    end
  end
end
