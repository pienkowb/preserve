require 'spec_helper'

RSpec.describe Preserve::SessionKey do
  let(:controller_class) { ParametersController }
  let(:parameter_key) { :status }

  subject { described_class.new(controller_class, parameter_key) }

  it 'builds a session key' do
    key = 'preserve_bf3517c011c4bb3e6e9382f538357766ea91ae7b'
    expect(subject.build).to eq(key)
  end

  context 'with a nested parameter' do
    let(:parameter_key) { %i[sort column] }

    it 'builds a session key' do
      key = 'preserve_e120e537974f1046d8b1c4e869e69df30f8e862f'
      expect(subject.build).to eq(key)
    end
  end

  context 'with a namespaced controller' do
    let(:controller_class) { Admin::ParametersController }

    it 'builds a session key' do
      key = 'preserve_8e9fa91c76a09b7483fc229526d59d652637daab'
      expect(subject.build).to eq(key)
    end
  end
end
