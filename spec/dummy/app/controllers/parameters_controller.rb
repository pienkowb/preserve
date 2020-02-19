class ParametersController < ApplicationController
  preserve :page, :per_page, only: :index
  preserve :status, allow_blank: true
  preserve :order, prefix: 'preserved'

  def index
    render json: request_parameters
  end

  def create
    render json: request_parameters
  end

  private

  def request_parameters
    params.except(:controller, :action)
  end
end
