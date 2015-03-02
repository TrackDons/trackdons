class ExternalServiceManager
  SUPPORTED_SERVICES = [:twitter, :facebook]

  def initialize(user)
    @user = user
  end

  attr_reader :user

  def self.authenticate(klass, auth_information)
    service = auth_information[:provider].to_sym
    raise "Invalid service" unless SUPPORTED_SERVICES.include?(service)

    if service == :twitter
      klass.with_twitter_id(auth_information[:info][:nickname]).first
    elsif service == :facebook
      klass.with_facebook_id(auth_information[:uid]).first
    end
  end

  def include?(service)
    raise "Invalid service" unless SUPPORTED_SERVICES.include?(service)

    user.send("#{service}_id".to_sym).present?
  end

  def unlink_from_service(service)
    raise "Invalid service" unless SUPPORTED_SERVICES.include?(service)

    case service
    when :twitter
      unlink_from_twitter
    when :facebook
      unlink_from_facebook
    end
  end

  def link_to_service(auth_information)
    service = auth_information[:provider].to_sym
    raise "Invalid service" unless SUPPORTED_SERVICES.include?(service)

    case service
    when :twitter
      link_to_twitter(auth_information)
    when :facebook
      link_to_facebook(auth_information)
    end
  end

  private

  def link_to_twitter(auth_information)
    user.twitter_id     = auth_information[:info][:nickname]
    user.twitter_token  = auth_information[:credentials][:token]
    user.twitter_secret = auth_information[:credentials][:secret]
    user.save!
  end

  def unlink_from_twitter
    user.twitter_id     = nil
    user.twitter_token  = nil
    user.twitter_secret = nil
    user.save!
  end


  def link_to_facebook(auth_information)
    user.facebook_id    = auth_information[:uid]
    user.facebook_token = auth_information[:credentials][:token]
    user.save!
  end

  def unlink_from_facebook
    user.facebook_id = nil
    user.facebook_token = nil
    user.save!
  end
end
