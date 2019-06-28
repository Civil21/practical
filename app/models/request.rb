class Request < ApplicationRecord
  has_many :comments
  validates :name, :text, :stat, :subject, presence: true
end
