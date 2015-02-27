Rails.application.config.middleware.use(OmniAuth::Builder) do
  provider :twitter, Rails.application.secrets.twitter_api_key, Rails.application.secrets.twitter_api_secret, {
    use_authorize: false
  }
  provider :facebook, "API_KEY", "API_SECRET"
end
