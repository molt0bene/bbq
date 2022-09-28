class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "#{t('mailer.new_subscription')} #{event.title}"
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: "#{t('mailer.new_comment')} @ #{event.title}"
  end

  def photo(event, photo, emails)
    @event = event
    @photo = photo

    mail to: emails, subject: "#{t('mailer.new_photo')} @ #{event.title}"
  end
end
