require "smtp_tls"

 
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
:address => "smtp.gmail.com",
:port => 587,
:authentication => :plain,
:user_name => "services.beat.in@googlemail.com",
:password => 'beatin123'}
