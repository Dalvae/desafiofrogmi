class AddTsunamiToFeatures < ActiveRecord::Migration[7.0]
  def change
    add_column :features, :tsunami, :boolean
  end
end
