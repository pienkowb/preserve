class ParametersController < ApplicationController
  def index
    render json: parameters
  end

  def create
    render json: parameters
  end

  private

  def parameters
    params.except(:controller, :action)
  end
end
