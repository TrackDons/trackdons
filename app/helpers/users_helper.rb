module UsersHelper

  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    gravatar_url = '#'
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def has_donations?
    logged_in? && current_user.donations.count > 0
  end

end
