class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  scope :created_at_desc, ->{order created_at: :desc}

  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.comment.max_content}
end
