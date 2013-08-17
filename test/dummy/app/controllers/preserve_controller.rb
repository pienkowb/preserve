class PreserveController < ApplicationController
  preserve :per_page, :order, only: :index
  preserve :status, prefix: 'test'

  def index
    render nothing: true
  end

  def show
    render nothing: true
  end
end
