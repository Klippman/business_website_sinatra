require "sinatra"
require "sendgrid-ruby"
include SendGrid

get "/" do
    erb :home, layout: :layout
end

get "/mission" do
    erb :mission, layout: :layout
end

get "/gallery" do
    erb :gallery, layout: :layout
end

get "/contact" do
    erb :contact, layout: :layout
end

post "/contact" do
    puts params.inspect
    @message = params[:message]

    from = Email.new(email: 'dklipp6@gmail.com')
    to = Email.new(email: 'dklipp6@gmail.com')
    subject = 'NYCDA test email'
    content = Content.new(type: 'text/plain', value: 'this is a test email from nycda class.')
    mail = Mail.new(from, subject, to, content)
    
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
end