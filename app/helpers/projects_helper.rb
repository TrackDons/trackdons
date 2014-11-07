module ProjectsHelper

  def prettify_url(url)
    url = url.gsub('www.', '')
    url = url.gsub('http://', '')
  end 

end
