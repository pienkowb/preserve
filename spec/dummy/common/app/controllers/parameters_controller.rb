class ParametersController < ApplicationController
  def index
    render json: parameters
  end

  def create
    render json: parameters
  end
end
