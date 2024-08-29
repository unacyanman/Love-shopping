class User < ApplicationRecord
  
  has_many :comments
  
  include ActionView::Helpers::AssetUrlHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def get_profile_image(width, height)
    asset_path('profile_image.jpg', host: 'https://example.com')
  end
         
end
