class Update < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  belongs_to :issue
  has_many :comments, :as => :commentable

  validates :name, presence: true
  validates :description, presence: true
  validates :citation, presence: true
  validates :score, presence: true

end
