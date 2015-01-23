class ProjectsController < ApplicationController
  
  before_filter :set_new_donation, only: :show
  before_action :load_project,      only: [:edit, :update, :destroy]

  def index
    if params[:category]    
      c = Category.friendly.find(params[:category])
      @projects = Project.where(:category_id => c.id)
      @page_title = c.name
    else  
      @projects = Project.search(params[:q])
      @page_title = t('metas.projects.home.title')
    end

    @categories = Category.all

    respond_to do |format|
      format.html
      format.json { render json: projects_with_urls(@projects)}
    end
  end

  def show
    @project = Project.friendly.includes(donations: [:user]).find(params[:id])
  end

  def new
    @project = Project.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def update
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated" 
      redirect_to @project
    else
      @categories = Category.all
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    flash[:success] = t '.deleted'
    redirect_to projects_path
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
      params.require(:project).permit(:name, :description, :url, :twitter, :donation_url, :category_id)
    end

    def load_project
      @project = Project.friendly.find(params[:id])
    end

    def projects_with_urls(projects)
      projects.map do |project|
        project.as_json.merge(project_url: url_for(project))
      end
    end

end
