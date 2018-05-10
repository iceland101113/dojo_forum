class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :categorizations
  has_many :categories, through: :categorizations
  belongs_to :user
  has_many :replies, dependent: :destroy 
  has_many :collections, dependent: :destroy
  has_many :collect_users, through: :collections, source: :user

  def is_published?
    self.situation == "Publish"
  end

  def is_collected?(user)
    self.collect_users.include?(user)
  end

end
