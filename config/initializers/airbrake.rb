Airbrake.configure do |config|
  config.api_key = Settings['errors']['key']
end
