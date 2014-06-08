require 'sinatra'
require 'pony'

before do
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Origin']  = '*'
    headers['Access-Control-Allow-Headers'] = 'accept, authorization, origin'
end

# whitelist should be a space separated list of URLs
whitelist = ENV['whitelist'].split

set :protection, :origin_whitelist => whitelist

Pony.options = {
  :via => :smtp,
  :via_options => {
    :address => 'smtp.sendgrid.net',
    :port => '587',
    :domain => 'heroku.com',
    :user_name => ENV['app21026139@heroku.com'],
    :password => ENV['proppros'],
    :authentication => :plain,
    :enable_starttls_auto => true
  }
}

get '/contact' do
  'you have reached the test!'
end

post '/contact' do
  email = ""
  params.each do |value|
    email += "#{value[0]}: #{value[1]}\n"
  end
  puts email
  Pony.mail(
    :to => ENV['email_recipients'],
    :from => 'noreply@example.com',
    :subject => 'New Contact Form',
    :body => email
  )
end
