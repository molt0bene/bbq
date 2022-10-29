class EventMailer < ApplicationMailer

  def subscription(subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = subscription.event

    mail to: subscription.event.user.email, subject: default_i18n_subject
  end

  def comment(comment, email)
    @comment = comment
    @event = comment.event

    mail to: email, subject: default_i18n_subject
  end

  def photo(photo, emails)
    @event = photo.event
    @photo = photo

    mail to: emails, subject: default_i18n_subject
  end
end
