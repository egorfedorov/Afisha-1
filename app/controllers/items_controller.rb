class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  caches_page :index
  def index
    @items = Item.includes([{:galleries=>:images},:categories]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json

  def show
    @item = Item.includes(:events=>[:place,:room]).order('events.date_begin','places.id').find(params[:id])




    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

end
