class Issue < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :updates
  has_many :comments, :as => :commentable

  validates :name, presence: true
  validates :description, presence:true

  def total_score
    self.updates.sum(:score)
  end
end
