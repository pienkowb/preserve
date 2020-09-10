class ApplicationController < ActionController::Base
  private

  def parameters
    params.except(:controller, :action)
  end
end
