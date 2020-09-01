class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  preserve :locale
end
