class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :description
      t.integer :days_to_harvest
      t.references :plots, foreign_key: true
    end
  end
end
