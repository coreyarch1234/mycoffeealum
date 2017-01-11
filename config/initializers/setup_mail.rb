ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              =>  'smtp.sendgrid.net',
  :port                 =>  '587',
  :authentication       =>  :plain,
  :user_name            =>  'app61983251@heroku.com',
  :password             =>  '2uax3l3p1098',
  :domain               =>  'heroku.com',
  :enable_starttls_auto  =>  true
}
