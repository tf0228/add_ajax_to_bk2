class Book < ApplicationRecord
	belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(book_title,search_method)
    if search_method == "perfect_match"
      Book.where("title LIKE ?","#{book_title}")
    elsif search_method == "forward_match"
      Book.where("title LIKE ?", "#{book_title}%")
    elsif search_method == "backward_match"
      Book.where("title LIKE ?", "%#{book_title}")
    elsif search_method == "partial_match"
      Book.where("title LIKE ?", "%#{book_title}%")
    else
      Book.all
    end
  end
end
