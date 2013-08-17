class PreserveController < ApplicationController
  preserve :per_page

  def index
    render nothing: true
  end
end
