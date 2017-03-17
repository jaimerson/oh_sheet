require 'rails_helper'

RSpec.describe OhSheet::ImportersController do
  routes { OhSheet::Engine.routes }

  describe 'POST import' do
    let(:params) do
      {
        file_to_import: file
      }
    end

    let(:file) { 'TODO: make this a fixture file upload' }

    context 'with the right params' do
      before do
        allow(OhSheet::ImporterJob).to receive(:perform_later)
      end

      it 'returns a success response' do
        post :import, resource_name: 'foo', **params
        expect(response).to be_success
      end

      it 'calls the importer for the given resource_name' do
        expect(OhSheet::ImporterJob).to receive(:perform_later)
          .with('FooImporter', file)
        post :import, resource_name: 'foo', **params
      end
    end

    context 'with missing params' do
      let(:params) { Hash.new }

      it 'returns an error response' do
        post :import, resource_name: 'foo', **params
        expect(response.status).to eq(422)
      end
    end
  end
end
