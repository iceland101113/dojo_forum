class Post < ApplicationRecord
  has_many :categorizations
  has_many :catgories, through: :categorizations

  mount_uploader :image, ImageUploader
end
