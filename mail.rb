require 'mailjet'
Mailjet.configure do |config|
  config.api_key = ENV['MAILJET_API_KEY']
  config.secret_key = ENV['MAILJET_SECRET_KEY']
  config.api_version = "v3.1"
end
variable = Mailjet::Send.create(messages: [{
                                             'From'=> {
                                               'Email'=> ENV['MAILJET_SENDER'],
                                               'Name'=> 'Kate'
                                             },
                                             'To'=> [
                                               {
                                                 'Email'=> 'vomed84794@dnitem.com',
                                                 'Name'=> 'Kate'
                                               }
                                             ],
                                             'Subject'=> 'Greetings from Mailjet.',
                                             'TextPart'=> 'My first Mailjet email',
                                             'HTMLPart'=> '<h3>Dear passenger 1, welcome to <a href=\'https://www.mailjet.com/\'>Mailjet</a>!</h3><br />May the delivery force be with you!',
                                             'CustomID' => 'AppGettingStartedTest'
                                           }]
)
p variable.attributes['Messages']
