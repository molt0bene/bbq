class SendEmailsJob < ApplicationJob
  queue_as :default

  def perform(model)
    # для подписки не нужно, т.к. там только один email

    # Собираем всех подписчиков и автора события в массив мэйлов
    all_emails = (model.event.subscriptions.map(&:user_email) + [model.event.user.email]).uniq

    all_emails.delete(model.user.email) if model.user.present?

    # По адресам из этого массива делаем рассылку
    if model.instance_of?(Comment)
      EventMailer.comment(model, all_emails).deliver_later
    elsif model.instance_of?(Photo)
      all_emails.each do |mail|
        EventMailer.photo(model, mail).deliver_later
      end
    end
  end
end
