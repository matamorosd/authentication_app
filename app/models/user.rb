class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[ facebook google_oauth2 ]

  has_one_attached :image


  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(name: data['name'],
            email: data['email'],
            password: Devise.friendly_token[0,20],
            first_name: data['first_name'],
            last_name: data['last_name'],
            image_url: data['image']
        )
    end
    user
  end

  def self.from_omniauth_fb(auth)
    name_split = auth.info.name.split(" ")
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider,
                          uid: auth.uid,
                          last_name: name_split[0],
                          first_name: name_split[1],
                          email: auth.info.email,
                          password: Devise.friendly_token[0, 20],
                          image_url: auth.info.image
                          )
      user
  end

  
end
