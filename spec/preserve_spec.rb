require 'spec_helper'

RSpec.describe Preserve, type: :request do
  it 'persists a parameter value' do
    get parameters_path, per_page: '20'
    get parameters_path

    expect(json_response[:per_page]).to eq('20')
  end

  it 'updates a parameter value' do
    get parameters_path, per_page: '20'
    get parameters_path, per_page: '10'

    expect(json_response[:per_page]).to eq('10')
  end

  it 'handles multiple parameters' do
    get parameters_path, page: '5', per_page: '20'
    get parameters_path

    expect(json_response[:page]).to eq('5')
    expect(json_response[:per_page]).to eq('20')
  end

  it 'handles action restrictions' do
    post parameters_path, per_page: '20'
    post parameters_path

    expect(json_response[:per_page]).to be_nil
  end

  it 'handles a blank parameter value' do
    get parameters_path, status: 'active'
    get parameters_path, status: ''

    expect(json_response[:status]).to eq('')
  end

  it 'handles a session key prefix' do
    get parameters_path, order: 'created_at'

    key = :preserved_parameters_order
    expect(session[key]).to eq('created_at')
  end

  it 'supports controller inheritance' do
    get parameters_path, locale: 'en'
    get parameters_path

    expect(json_response[:locale]).to eq('en')
  end
end
