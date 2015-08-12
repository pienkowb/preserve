class ApplicationController < ActionController::Base
  protect_from_forgery
  preserve :locale
end
