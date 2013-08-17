class PreserveController < ApplicationController
  preserve :per_page, :order

  def index
    render nothing: true
  end
end
