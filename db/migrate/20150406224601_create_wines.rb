class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :winery
      t.string :name
      t.string :varietal
      t.integer :vintage
      t.string :region
      t.string :appellation
      t.string :state
      t.string :country
      t.integer :quantity
      t.timestamps
    end
  end
end
