class Request < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :name, :text, :stat, :subject, presence: true, if: :can_validate?
  validates :client_id, numericality: true, length: { minimum: 10, maximum: 10 }, allow_blank: true, if: :can_validate?
  validates :phone, numericality: true, length: { minimum: 10, maximum: 15 }, allow_blank: true, if: :can_validate?
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true, if: :can_validate?

  def can_validate?
    true
  end

  def last_active
    if comments.length > 1
      comments.last.created_at
    else
      created_at
    end
  end
end
