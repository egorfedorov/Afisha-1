class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  #include TheSortableTreeController::Rebuild
  #caches_page :index

  #caches_action :show

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


    #@items=@category.items_in_category.page(params[:page])
    #@items=@category.items_in_category
    #Rails.cache.fetch('category', :expires_in => 24.hours) do
      #@schedule = Schedule.get_by_category(@category)
             @category = Category.find(params[:id])

    #end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end


end
