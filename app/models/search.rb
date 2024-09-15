class Search < ApplicationRecord
  
  def self.looks(search, word)
    # 検索処理の実装
    # UserモデルやPostモデルに対して実際の検索処理を行うコードを記述してください
    
    if search == "User"
      # Userの検索処理を実行し、結果を返す
      User.where("name LIKE ?", "%#{word}%")
    else
      # Postの検索処理を実行し、結果を返す
      Post.where("body LIKE ?", "%#{word}%")
    end
  end  
  
end
