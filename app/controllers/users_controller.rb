
class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index]




  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
     # get_weather
      redirect_to @user
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @zipper = current_user.zip_code.to_s
    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end





  private

  def user_params
    params.require('user').permit(:email, :phone, :zip_code)
  end


end
