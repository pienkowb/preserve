module Admin
  class ParametersController < ApplicationController
    def index
      render json: parameters
    end
  end
end
