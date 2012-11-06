class MyTestsController < ApplicationController
  # GET /tests
  # GET /tests.json
  def index
    #@tests = Test.all

    respond_to do |format|
      format.html # index.html.erb

    end
  end


end
