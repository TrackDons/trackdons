module ProjectsHelper

  def prettify_url(url)
    url = url.gsub('www.', '')
    url = url.gsub('http://', '')
  end

  def projects_page_title
    return t('metas.projects.home.title') if @category.nil? && @country.nil?

    if @category && @country
      t('metas.projects.home.title_with_category_and_country', category: @category.name, country: t(@country, :scope => :countries))
    else
      if @category
        t('metas.projects.home.title_with_category', category: @category.name)
      elsif @country
        t('metas.projects.home.title_with_country', country:  t(@country, :scope => :countries))
      end
    end
  end

  def options_for_countries_select
    @options_for_countries_select ||= [[t('.global'), projects_with_filter_path(@category, nil)]] + Project.used_countries.map do |country_name, country_code|
      [country_name, projects_with_filter_path(@category, country_code)]
    end
  end

  def projects_with_filter_path(category, country, extra_params = {})
    filters = []
    filters << [:category, category] if category
    filters << [:country, country] if country
    filters.flatten!

    extra_params.merge!({sort_by: params[:sort_by]}) if !extra_params[:sort_by] && params[:sort_by]

    url_params = {}
    url_params.merge!({filters: filters}) if filters.any?
    url_params.merge!(extra_params) if extra_params.any?

    projects_filtered_path(url_params)
  end

end
