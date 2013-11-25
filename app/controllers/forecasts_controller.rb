class ForecastsController < ApplicationController


  def show
    @forecast = Forecast.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @forecast }
    end
  end

  def index
    key = ENV['WEATHER_API_KEY']
    @weather = HTTParty.get 'http://api.worldweatheronline.com/free/v1/weather.ashx?q=' + current_user.zip_code.to_s + '&format=json&num_of_days=1&key=' + key
    response = JSON.parse(@weather.body)
    response["data"]["current_condition"].map do |item|
      i =    item["weatherIconUrl"][0]["value"]
      s = item["temp_F"]
      forecast(s, i)

    end
  end




  def forecast(temp, img)

    @image = img

    def image
      @image
    end
    @degrees = temp
    def results
      if @degrees.to_i < 70
        "you better bring a jacket, it is going to be #{@degrees} degrees today."
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
    if  @forecast.save
      redirect_to  @forecast
    else
      render :index
    end
  end


end
