class Item < ApplicationRecord
  belongs_to :user
  
  validates :purchase_date, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  
end
