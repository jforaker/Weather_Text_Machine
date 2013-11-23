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
    @account_sid = 'AC40a62239206f477748434e421fd9ded1'
    @auth_token = 'db47dea9d29602abebadfc821cac6d4c'
    @from_twil = '8313594235'
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    @message = @account.sms.messages.create({:from => @from_twil, :to => @phone_number, :body => @message_body})
  end


end
