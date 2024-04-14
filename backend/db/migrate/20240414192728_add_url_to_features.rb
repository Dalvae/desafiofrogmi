class AddUrlToFeatures < ActiveRecord::Migration[7.0]
  def change
    add_column :features, :url, :string
  end
end
