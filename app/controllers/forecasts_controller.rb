class ForecastsController < ApplicationController

  def show
    @forecast = Forecast.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @forecast }
    end
  end

  #testing stuff
  def create
    @user = current_user
    if @user.update_attributes(user_params)
      # get_weather
      key = ENV['WEATHER_API_KEY']
      loc =   URI.encode(current_user.location)
      @weather = HTTParty.get 'http://api.worldweatheronline.com/free/v1/weather.ashx?q=' + loc + '&format=json&num_of_days=1&key=' + key
      response = JSON.parse(@weather.body)
      response["data"]["current_condition"].map do |item|
        i =    item["weatherIconUrl"][0]["value"]
        s = item["temp_F"]
        forecast(s, i)
      end
    else
      render :edit
    end

  end

  #def index
  #  key = ENV['WEATHER_API_KEY']
  #  loc =   URI.encode(current_user.location)
  #  @weather = HTTParty.get 'http://api.worldweatheronline.com/free/v1/weather.ashx?q=' + loc + '&format=json&num_of_days=1&key=' + key
  #  response = JSON.parse(@weather.body)
  #  response["data"]["current_condition"].map do |item|
  #    i =    item["weatherIconUrl"][0]["value"]
  #    s = item["temp_F"]
  #    forecast(s, i)
  #  end
  #end

  def forecast(temp, img)

    @image = img

    def image
      @image
    end
    @degrees = temp
    def results
      if @degrees.to_i < 70 && @degrees.to_i >= 40
        "you better bring a jacket, it is going to be #{@degrees} degrees today."
      elsif @degrees.to_i < 40
        "dude, its freezing. #{@degrees} degrees and not getting any hotter"
      else
        "grab your sunscreen, it's going to be #{@degrees} degrees today."
      end
    end
    save_forecast(results, image)
  end

  def save_forecast(results, image)
    forecast_params = params[:id]
    @forecast = Forecast.new(forecast_params)
    @forecast.image = image
    @forecast.message = results
    @forecast.location = URI.encode(current_user.location).downcase.tr(" ", "_")
    if  @forecast.save
      redirect_to  @forecast
    else
      render :index
    end
  end

  def forecast_params
    params.require('forecast').permit(:location)
  end

  private

  def user_params
    params.require('user').permit(:email, :phone, :zip_code, :location)
  end

end