class AddForecastIdToForecasts < ActiveRecord::Migration
  def change
    add_column :forecasts, :forecast_id, :integer
  end
end
