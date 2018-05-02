class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :categorizations
  has_many :catgories, through: :categorizations

  def is_published?
    self.situation == "Publish"
  end

end
