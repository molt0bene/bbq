class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50]
  end

  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :comments, dependent: :destroy
  has_many :photos, dependent: :destroy

  validates :user, presence: true

  validates :title, presence: true, length: {maximum: 255}
  validates :address, presence: true
  validates :datetime, presence: true

  def visitors
    (subscribers + [user]).uniq
  end
end
