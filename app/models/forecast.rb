class Forecast < ActiveRecord::Base
  belongs_to :user
  #before_save :create_forecast_permalink
  #
  #def to_param
  #  location
  #end
  #
  #private
  #
  #def create_forecast_permalink
  #  #namer = Forecast.location.downcase.tr(" ", "_")
  #  self.location = self.location + Time.now.to_datetime.to_s
  #end

end
