class AddLocationToForecasts < ActiveRecord::Migration
  def change
    add_column :forecasts, :location, :string
  end
end
