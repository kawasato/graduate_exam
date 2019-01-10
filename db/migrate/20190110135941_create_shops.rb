class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.date :visitdate
      t.string :shop_name
      t.string :address
      t.text :shop_image
      t.text :bread_name1
      t.text :bread_image1
      t.text :bread_name2
      t.text :bread_image2
      t.text :bread_name3
      t.text :bread_image3


      t.timestamps
    end
  end
end
