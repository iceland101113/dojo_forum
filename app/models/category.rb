class Category < ApplicationRecord
  has_many :categorizations, dependent: :restrict_with_exception 
  has_many :posts, through: :categorizations
end
