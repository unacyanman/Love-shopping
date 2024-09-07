class User < ApplicationRecord
  
  has_many :comments
  has_many :posts
  has_one_attached :profile_image
  validates :name, presence: true
  
  include ActionView::Helpers::AssetUrlHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
       
  def get_profile_image(width, height)
    # プロフィール画像のURLを生成する処理
    image_url = profile_image.variant(resize_to_limit: [width, height])

    # 幅と高さを指定したリサイズ処理
    # resized_image_url = generate_resized_image_url(image_url, width, height)

    # リサイズ後の画像のURLを返す
    # default_image_url = asset_path('default_profile_image.jpg')
    return image_url
  end

  private

  def generate_resized_image_url(image_url, width, height)
    # リサイズ処理を実装する
    # ここでは簡単な例として、サンプルのURLに幅と高さのクエリパラメータを追加したものを返す
    resized_image_url = "#{image_url}?w=#{width}&h=#{height}"
    return resized_image_url
  end     
        
end
