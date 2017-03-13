require 'rails_helper'

RSpec.describe OhSheet::ImportersController do
  routes { OhSheet::Engine.routes }

  class FooImporter
    def initialize(file)
    end
  end

  describe 'POST import' do
    let(:params) do
      {
        file_to_import: file
      }
    end

    let(:file) { StringIO.new }

    context 'with the right params' do
      let(:importer) { double(import: true) }

      before do
        allow(FooImporter).to receive(:new).and_return(importer)
      end

      it 'returns a sucess response' do
        post :import, resource_name: 'foo', **params
        expect(response).to be_success
      end

      it 'calls the importer for the given resource_name' do
        expect(FooImporter).to receive(:new).and_return(importer)
        post :import, resource_name: 'foo', **params
      end

      context 'when the importer has errors' do
        let(:importer) { double(import: false, errors: ['Some errors :(']) }

        it 'returns an error response' do
          post :import, resource_name: 'foo', **params
          expect(response.status).to eq(422)
        end

        it 'returns the importer errors' do
          post :import, resource_name: 'foo', **params
          expect(JSON.parse(response.body)['errors']).to eq(importer.errors)
        end
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
