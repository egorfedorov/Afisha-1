class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  include TheSortableTreeController::Rebuild
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
    @category = Category.include(:events).find(params[:id]).self_and_descendants

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end


end
