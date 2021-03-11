class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


  has_many :sent_friendships, class_name: "Friendship", source: "sender"
  has_many :received_friendships, class_name: "Friendship", source: "receiver"


  def self.friends(current_user)
    current_user.sent_friendships.where(status:true) ## Plus
    current_user.received_friendships.where(status:true)
  end

  def self.sent_friendships(current_user)
    current_user.sent_friendships.where(status:false)
  end

  def self.pending_friendships(current_user)
    current_user.received_friendships.where(status:false)
  end





end
