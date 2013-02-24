class MyTestsController < ApplicationController

  # GET /my_tests
  # GET /my_tests.json
  def index

    #@result = Schedule.get_by_place Place.find 87
    #@result2 = Schedule.get_by_place2 Place.find 87

    #respond_to do |format|
    #  format.html
    #
    #  format.json { render json: @my_tests }
    #
    #end
    render 'my_tests/index' , layout:false
  end



end
