OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '970452492560-7763k5g6fa9h3pnsofqsgdkpjf9k27b4.apps.googleusercontent.com', '4kUff49sJV4cV6yqV2RdKItB', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end