module ApplicationHelper

  def available_locales
    current_locale = I18n.locale
    locale_links = []
    if request.standard_port != request.port
      port = ':' + request.port.to_s
    end
    I18n.available_locales.each do |locale_to_iterate|
      locale_links << link_to_unless(current_locale == locale_to_iterate, language_name_for(locale_to_iterate), url_for(:host => "#{locale_to_iterate}.#{ENV['domain']}"))
    end
    locale_links
  end

  def track_donation_link
    return "#{root_path}#track_donation"
  end
  
  def markdown(text)
    return if text.blank?

    options = {
      filter_html:     true,
      hard_wrap:       true, 
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true, 
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
  
  private
  def language_name_for(locale)
    I18n.backend.send(:translations)[locale][:language_name]
  end
end
