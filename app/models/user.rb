class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  def self.sign_in_from_omniauth(auth)   
    User.find_by(provider: auth["provider"], uid: auth["uid"]) || create_user_from_omniauth(auth)
  end

  def self.create_user_from_omniauth(auth)
    user = User.find_or_create_by(email: auth.info.email)
    user.skip_confirmation!
    user.save(validate: false)
    user = User.create(provider: auth["provider"],uid: auth["uid"], user_id: user.id )
    user.save(validate: false)
  end

  # def self.from_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #     user.oauth_token = auth.credentials.token
  #     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     user.save!
  #   end
  # end
end
