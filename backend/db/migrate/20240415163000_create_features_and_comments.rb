class CreateFeaturesAndComments < ActiveRecord::Migration[7.0]
    def change
      create_table :features do |t|
        t.string :external_id
        t.decimal :magnitude
        t.string :place
        t.string :time
        t.boolean :tsunami
        t.string :mag_type
        t.string :title
        t.decimal :longitude
        t.decimal :latitude
        t.string :url
        t.timestamps
      end
  
      create_table :comments do |t|
        t.text :body
        t.string :name
        t.references :feature, null: false, foreign_key: true
        t.timestamps
      end
    end
  end