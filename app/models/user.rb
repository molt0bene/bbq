class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :events
  has_many :subscriptions
  has_many :comments, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [50, 50]
  end

  validates :name, presence: true, length: {maximum: 35}

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private

  def set_name
    self.name = "#{I18n.t('activerecord.models.user')} ##{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end
