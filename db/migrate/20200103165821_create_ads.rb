class CreateAds < ActiveRecord::Migration[6.0]
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.integer :views
      t.integer :likes

      t.timestamps
    end
  end
end
