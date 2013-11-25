class TextsController < ApplicationController

  def new
    @name = current_user.name
    @zip_code = current_user.zip_code
    @phone_number = current_user.phone
    @forecast = Forecast.last
    @message_body = "Hi " + @name + "- in " + @zip_code.to_s + ', the weatherman says: hey ' + @forecast.message
    make_call
  end

  def make_call
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    @account = @client.account
    @message = @account.sms.messages.create({:from => ENV['FROM_TWILIO_NUMBER'], :to => @phone_number, :body => @message_body})
  end

end
