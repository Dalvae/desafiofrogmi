class Comment < ApplicationRecord
  belongs_to :feature

  validates :body, presence: true
  validates :name, presence: true
end