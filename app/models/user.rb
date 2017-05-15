class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :vkontakte]
  validates :name, presence: true, length: {maximum: 50}

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.uid = data['id']
        user.provider = 'facebook'
        user.email = data['email'] if user.email.blank?
      end

      if data = session['devise.vkontakte_data'] && session['devise.vkontakte_data']['extra']['raw_info']
        user.uid = data['id']
        user.provider = 'vkontakte'
        user.name = "#{data['first_name']} #{data['last_name']}" if user.name.blank?
      end
    end
  end
end
