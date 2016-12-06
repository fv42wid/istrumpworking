class Issue < ApplicationRecord
  belongs_to :user
  has_many :updates

  validates :name, presence: true
  validates :description, presence:true
end
