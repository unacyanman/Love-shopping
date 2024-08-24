class Post < ApplicationRecord

  has_one_attached :image
  paginates_per 10
  belongs_to :user
end
