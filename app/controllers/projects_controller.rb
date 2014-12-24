class ProjectsController < ApplicationController
  before_filter :set_new_donation, only: :show

  def index
    @projects = Project.search(params[:q])

    respond_to do |format|
      format.html
      format.json { render json: projects_with_urls(@projects)}
    end
  end

  def show
    @project = Project.friendly.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, flash: { success: t('.project_created') }
    else
      render 'new'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :url, :twitter)
  end

  def projects_with_urls(projects)
    projects.map do |project|
      project.as_json.merge(project_url: url_for(project))
    end
  end
end
