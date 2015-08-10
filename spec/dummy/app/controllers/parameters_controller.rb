class ParametersController < ApplicationController
  preserve :per_page, :page, only: :index
  preserve :order, prefix: 'preserved'

  def index
    render json: request_parameters
  end

  def create
    render json: request_parameters
  end

  private

  def request_parameters
    params.except :controller, :action
  end
end
