class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :categorizations
  has_many :categories, through: :categorizations
  belongs_to :user
  has_many :replies, dependent: :destroy 

  def is_published?
    self.situation == "Publish"
  end

end
