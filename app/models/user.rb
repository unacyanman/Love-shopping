class User < ApplicationRecord
  
  has_many :comments
  has_many :posts, dependent: :destroy
  has_one_attached :profile_image
  
  validates :name, presence: true
  
  include ActionView::Helpers::AssetUrlHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
       
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default_profile_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  private

  def generate_resized_image_url(image_url, width, height)
    # リサイズ処理を実装する
    # ここでは簡単な例として、サンプルのURLに幅と高さのクエリパラメータを追加したものを返す
    resized_image_url = "#{image_url}?w=#{width}&h=#{height}"
    return resized_image_url
  end     
        
end
