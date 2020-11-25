class Brand < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, presence: true,
    length: {maximum: Settings.brand.name.max_length},
    uniqueness: {case_sensitive: false}
  scope :order_name_asc, ->{order :name}
end
