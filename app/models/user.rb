class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :issues
  has_many :updates

  validates :email, presence: true, length: {minimum: 3}
  validates :username, presence: true, length: {maximum: 50}
end
