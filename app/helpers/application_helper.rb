module ApplicationHelper

  def available_locales
    current_locale = request.subdomains.first.to_sym
    @locales = I18n.available_locales
    @locale_link = []
    if request.standard_port != request.port
      port = ':' + request.port.to_s
    end
    @locales.each do |locale_to_iterate|
      if current_locale == locale_to_iterate
        @locale_link << I18n.backend.send(:translations)[locale_to_iterate][:language_name]
      else
        @locale_link << link_to(I18n.backend.send(:translations)[locale_to_iterate][:language_name], "http://#{locale_to_iterate}.#{ENV['domain']}#{port}#{request.fullpath}")
      end
    end
    @locale_link
  end 


end
