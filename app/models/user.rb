class User < ApplicationRecord
  
  has_many :comments, dependent: :destroy
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
  
  # 検索機能
  def self.looks(search, word)
    # 完全一致
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    # 前方一致
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    # 後方一致
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    # 部分一致
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
  
  
  private

  def generate_resized_image_url(image_url, width, height)
    # リサイズ処理を実装する
    # ここでは簡単な例として、サンプルのURLに幅と高さのクエリパラメータを追加したものを返す
    resized_image_url = "#{image_url}?w=#{width}&h=#{height}"
    return resized_image_url
  end     
        
  validates :name, uniqueness: true
  validates :name, presence: true
  validates :name, length: { in: 1..20 }
  
  validates :introduction, length: { maximum: 50 }
        
end
