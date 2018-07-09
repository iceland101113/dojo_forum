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

  def self.publish_all
    where("authority = ? and situation = ?", "1", "Publish")
  end

  def self.publish_myself(user_id)
    where(authority: "3", situation: "Publish", user_id: user_id)
  end

  def self.publish_friends(friends_id)
    where(user_id:friends_id, situation: "Publish", authority: "2" )
  end

end
