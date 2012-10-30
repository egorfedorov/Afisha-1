class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  #include TheSortableTreeController::Rebuild
  #caches_page :index
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    #@items=@category.items_in_category.page(params[:page])
    #@items=@category.items_in_category
    #Rails.cache.fetch('schedule', :expires_in => 24.hours) do
    #  @schedule = Schedule.get_by_category(@category)
    #end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end


end
