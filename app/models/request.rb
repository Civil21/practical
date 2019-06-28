class Request < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :name, :text, :stat, :subject, presence: true
end
