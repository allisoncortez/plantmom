class CreatePlants < ActiveRecord::Migration
  def change
    create_table :plants do |t|
      t.string :name
      t.string :soil
      t.string :sun_light
      t.string :water
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
