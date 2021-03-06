class ProjectsController < ApplicationController

  before_action :logged_in_user, only: [:new, :create]
  before_action :load_categories,  only: [:index, :new, :create, :edit, :update]
  before_action :load_countries,  only: [:index]
  before_action :load_project,     only: [:edit, :update, :destroy, :follow, :unfollow]

  ORDER_TYPES   = ['latest', 'alpha', 'popular']
  DEFAULT_ORDER = 'latest'

  FILTERS_AVAILABLE = ['category', 'country']

  def index
    @order = params[:sort_by] || DEFAULT_ORDER

    if params[:filters]
      load_projects_from_filters(params[:filters])
    else
      @projects = Project.search(params[:q])
    end

    @projects = @projects.send(@order.to_sym)

    respond_to do |format|
      format.html
      format.json { render json: projects_with_urls(@projects)}
    end
  end

  def show
    @project = Project.friendly.includes(donations: [:user]).find(params[:id])
    @donations = @project.donations.includes(:project, :user).sorted
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated"
      redirect_to @project
    else
      render 'edit'
    end
  end

  # removing destroy action until we have some permissions thing
  # def destroy
  #   @project.destroy
  #   flash[:success] = t '.deleted'
  #   redirect_to projects_path
  # end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, flash: { success: t('.project_created') }
    else
      render 'new'
    end
  end

  def follow
    current_user.follow(@project)
    respond_to do |format|
      format.html { redirect_to @project }
      format.js
    end
  end

  def unfollow
    current_user.stop_following(@project)
    respond_to do |format|
      format.html { redirect_to @project }
      format.js
    end
  end

  private

    def project_params
      params.require(:project).permit(:name, :description, :url, :twitter, :donation_url, :category_id, countries: [])
    end

    def load_project
      @project = Project.friendly.find(params[:id])
    end

    def projects_with_urls(projects)
      projects.map do |project|
        project.as_json.merge(project_url: url_for(project))
      end
    end

    def load_categories
      @categories = Category.order(slug: :desc)
    end

    def load_countries
      @countries = Project.used_countries.sort{|a,b| a[0] <=> b[0] }
    end

    def load_projects_from_filters(filters)
      @projects = Project

      filters.split('/').in_groups_of(2).each do |filter_group|
        filter_name, filter_value = filter_group
        next if !FILTERS_AVAILABLE.include?(filter_name)

        if filter_name == 'category'
          @category = Category.friendly.find(filter_value)
          @projects = @projects.category(@category)
        elsif filter_name == 'country'
          @country = filter_value
          @projects = @projects.country(@country)
        end
      end
    end

end
