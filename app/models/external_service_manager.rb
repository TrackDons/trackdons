class ExternalServiceManager
  SUPPORTED_SERVICES = [:twitter]

  def initialize(user)
    @user = user
  end

  attr_reader :user

  def include?(service)
    raise "Invalid service" unless SUPPORTED_SERVICES.include?(service)

    user.send("#{service}_login".to_sym).present?
  end

  def unlink_from_service(service)
    raise "Invalid service" unless SUPPORTED_SERVICES.include?(service)

    user.send("#{service}_login=".to_sym, nil)
    user.send("#{service}_token=".to_sym, nil)
    user.send("#{service}_secret=".to_sym, nil)
    user.save!
  end

  def link_to_service(service, auth_information)
    # Twitter credentials are linked to the user
    user.send("#{service}_login=".to_sym,  auth_information[:info][:nickname])
    user.send("#{service}_token=".to_sym,  auth_information[:credentials][:token])
    user.send("#{service}_secret=".to_sym, auth_information[:credentials][:secret])
    user.save!
  end
end
