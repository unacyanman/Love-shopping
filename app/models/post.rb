class Post < ApplicationRecord
  
  has_many :favorites
  has_many :comments, dependent: :destroy
  has_one_attached :image
  paginates_per 10
  belongs_to :user
  
  validates :title, presence: true
  validates :body, presence: true
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_yoko.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def get_profile_image(width, height)
    # プロフィール画像のURLを生成する処理
    image_url = profile_image.variant(resize_to_limit: [width, height])

    # 幅と高さを指定したリサイズ処理
    # resized_image_url = generate_resized_image_url(image_url, width, height)

    # リサイズ後の画像のURLを返す
    # default_image_url = asset_path('default_profile_image.jpg')
    return image_url
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    # 完全一致
    if search == "perfect_match"
      return Post.where("body LIKE?", "#{word}")
    # 前方一致
    elsif search == "forward_match"
      return Post.where("body LIKE?", "#{word}")
    # 後方一致
    elsif search == "backward_match"
      return Post.where("body LIKE?", "#{word}")
    # 部分一致
    elsif search == "partial_match"
      return Post.where("body LIKE?", "#{word}")
    else
      return Post.all
    end
  end
  
end
