require 'spec_helper'

RSpec.describe Preserve, type: :request do
  it 'persists a parameter value' do
    get parameters_path, per_page: 20
    get parameters_path

    expect(json[:per_page].to_i).to eq 20
  end

  it 'updates a parameter value' do
    get parameters_path, per_page: 20
    get parameters_path, per_page: 10

    expect(json[:per_page].to_i).to eq 10
  end

  it 'handles multiple parameters' do
    get parameters_path, per_page: 20, page: 5
    get parameters_path

    expect(json[:per_page].to_i).to eq 20
    expect(json[:page].to_i).to eq 5
  end

  it 'handles restrictions' do
    post parameters_path, per_page: 20
    post parameters_path

    expect(json[:per_page]).to be_nil
  end

  it 'supports a session key prefix' do
    get parameters_path, order: 'created_at'

    key = :preserved_parameters_order
    expect(session[key]).to eq 'created_at'
  end
end
