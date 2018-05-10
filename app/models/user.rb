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

  def admin?
    self.role_id == 2
  end
  
end
