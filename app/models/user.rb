class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, PhotoUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy 
  has_many :replies
  has_many :collections, dependent: :destroy
  has_many :collect_posts, through: :collections, source: :post

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: "Friendship", foreign_key:"friend_id"
  has_many :infriends, through: :inverse_friendships, source: :user

  validates_uniqueness_of :email

  def admin?
    self.role_id == 2
  end
  
  def is_friend?(user)
    self.friends.include?(user) 
  end

  before_create :generate_authentication_token

  def generate_authentication_token
     self.authentication_token = Devise.friendly_token
  end

end
