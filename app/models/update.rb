class Update < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  validates :name, presence: true
  validates :description, presence: true
  validates :citation, presence: true
  validates :score, presence: true

end
