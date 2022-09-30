class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: -> { user.present? }

  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }
  validate :own_event_subscription
  #validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }
  validate :anon_user_email

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def own_event_subscription
    if user == event.user
      errors.add(:user, :own_event)
    end
  end

  def anon_user_email
    all_emails = User.all.to_a.map(&:email)

    if all_emails.include?(user_email)
      errors.add(:user, :email_already_exists)
    end
  end
end
