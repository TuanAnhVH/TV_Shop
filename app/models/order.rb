class Order < ApplicationRecord
  belongs_to :user
  enum status: {begin: 0, processing: 1, shipping: 2, delivered: 3,
                end: 4, canceled: 5}
end
