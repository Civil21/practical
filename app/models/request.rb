class Request < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :name, :text, :stat, :subject, presence: true

  def last_active
    if comments.length > 1
      comments.last.created_at
    else
      created_at
    end
  end
end
