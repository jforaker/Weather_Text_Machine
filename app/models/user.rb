class User < ActiveRecord::Base
  # attr_accessible :provider, :uid, :name, :email
  validates_presence_of :name
 # before_save :create_permalink

  def self.create_with_omniauth(auth)
    create! do |user|
      @user = user
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
        user.permalink =  (auth['info']['name'] || "").downcase.tr(" ", "_")
        user.image =  auth['info']['image'] || ""
      end
    end
  end

  def to_param
    permalink
  end

  private

  def user_params
    params.require('user').permit(:provider, :uid, :name, :email, :user, :permalink)
  end

  def create_permalink
    namer = @user.name.downcase.tr(" ", "_")
    self.permalink = namer
  end

end
