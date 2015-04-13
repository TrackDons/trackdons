module ApplicationHelper

  def flash_message
    if flash[:error]
      content_tag(:div, class: "alert alert-error") do
        flash[:error]
      end
    elsif flash[:success]
      content_tag(:div, class: "alert alert-success") do
        flash[:success]
      end
    end
  end

  def modal_flash_message(modal)
    flash_type = "modal_#{modal}_error".to_sym

    if flash[flash_type]
      content_tag(:div, class: "alert alert-error") do
        flash[flash_type]
      end
    end
  end

  def track_donation_path
    "#{root_path}#modal-track"
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
