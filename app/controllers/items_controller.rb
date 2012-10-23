class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
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
    @item = Item.includes(:events=>:place).order('events.date_begin','places.id').find(params[:id])

    @events = @item.events


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

end
