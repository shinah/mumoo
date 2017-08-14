class CreateExhibitionsTags < ActiveRecord::Migration
  def change
    create_table :exhibitions_tags, :id => false do |t|
      t.references :exhibition, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
    end
  end
end
