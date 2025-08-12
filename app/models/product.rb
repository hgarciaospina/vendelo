class Product < ApplicationRecord
  has_one_attached :photo
  
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  belongs_to :category
end