class AddImageToForecasts < ActiveRecord::Migration
  def change
    add_column :forecasts, :image, :string
  end
end
