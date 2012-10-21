class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    @items = Item.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.includes(:places=>[:events]).find(params[:id])
     @places = @item.places

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

end
