class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :size
  has_many :comments, dependent: :destroy
  scope :order_by_create, ->{order created_at: :desc}
  scope :order_by_update, ->{order updated_at: :desc}
  delegate :name, to: :brand, prefix: true, allow_nil: true
  delegate :name, to: :size, prefix: true, allow_nil: true
  scope :search_by_name, ->(key){where("name LIKE ?", "%#{key}%")}
  has_one_attached :image

  validates :name, presence: true,
    length: {maximum: Settings.product.max_name}
  validates :price, presence: true,
    length: {maximum: Settings.product.max_price}

  def display_image
    image.variant(resize_to_limit: [Settings.product.limit_img,
      Settings.product.limit_img])
  end

  def feed
    comments.created_at_desc
  end
end
