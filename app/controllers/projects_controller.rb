class ProjectsController < ApplicationController
  
  autocomplete :project, :name

  def index
    @projects = Project.all
  end

  def show
    @project = Project.friendly.find(params[:id])
  end

  def new
    @project = Project.new
  end
 
  def create
    # render plain: params[:project].inspect
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
