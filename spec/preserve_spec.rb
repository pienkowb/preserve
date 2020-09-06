require 'spec_helper'

RSpec.describe Preserve, type: :request do
  before(:each) { reset_callbacks(ParametersController) }

  it 'persists a parameter value' do
    ParametersController.preserve(:status)

    get parameters_path, params: { status: 'active' }
    get parameters_path

    expect(json_response[:status]).to eq('active')
  end

  it 'updates a parameter value' do
    ParametersController.preserve(:status)

    get parameters_path, params: { status: 'active' }
    get parameters_path, params: { status: 'inactive' }
    get parameters_path

    expect(json_response[:status]).to eq('inactive')
  end

  it 'handles multiple parameters' do
    ParametersController.preserve(:page, :per_page)

    get parameters_path, params: { page: '2', per_page: '20' }
    get parameters_path

    expect(json_response[:page]).to eq('2')
    expect(json_response[:per_page]).to eq('20')
  end

  it 'applies action restrictions' do
    ParametersController.preserve(:status, only: :index)

    post parameters_path, params: { status: 'active' }
    post parameters_path

    expect(json_response[:status]).to eq(nil)
  end

  it 'handles a blank parameter value' do
    ParametersController.preserve(:status, allow_blank: true)

    get parameters_path, params: { status: 'active' }
    get parameters_path, params: { status: '' }

    expect(json_response[:status]).to eq('')
  end

  it 'handles a session key prefix' do
    ParametersController.preserve(:status, prefix: 'preserved')

    get parameters_path, params: { status: 'active' }
    get parameters_path

    expect(json_response[:status]).to eq('active')

    expect(session[:preserved_parameters_status]).to eq('active')
  end

  it 'supports controller inheritance' do
    ApplicationController.preserve(:locale)

    get parameters_path, params: { locale: 'en' }
    get parameters_path

    expect(json_response[:locale]).to eq('en')
  end

  context 'without a preserve callback' do
    it "doesn't persist parameter values" do
      get parameters_path, params: { status: 'active' }
      get parameters_path

      expect(json_response[:status]).to eq(nil)
    end
  end
end
