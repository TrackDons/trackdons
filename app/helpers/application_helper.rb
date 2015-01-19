module ApplicationHelper

  def track_donation_path
    "#{root_path}#track_donation"
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

  def current_user_profile?
    @user == current_user
  end
end
