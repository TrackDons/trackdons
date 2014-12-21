class ProjectsController < ApplicationController
  before_filter :set_new_donation, only: :show

  def index
    @projects = Project.search(params[:q])
    respond_to do |format|
      format.html
      format.json { render json: @projects}
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
      flash[:success] = "Project created. Share the word and start donation-saving!"
      redirect_to @project
    else
      render 'new'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :url, :twitter)
  end

end
