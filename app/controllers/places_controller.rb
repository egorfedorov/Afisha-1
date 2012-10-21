class PlacesController < ApplicationController
  # GET /places
  # GET /places.json
  def index
    @places = Place.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.includes(:events=>:items ).find(params[:id])
    @events= @place.events.page(params[:page])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end
end
