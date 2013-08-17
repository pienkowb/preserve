class PreserveController < ApplicationController
  preserve :per_page, :order, only: :index

  def index
    render nothing: true
  end

  def show
    render nothing: true
  end
end
