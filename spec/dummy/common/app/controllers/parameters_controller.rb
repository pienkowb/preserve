class ParametersController < ApplicationController
  preserve :page, :per_page, only: :index
  preserve :status, allow_blank: true
  preserve :order, prefix: 'preserved'

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
