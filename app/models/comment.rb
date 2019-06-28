class Comment < ApplicationRecord
  belongs_to :request
  validates :author, :text, presence: true
end
