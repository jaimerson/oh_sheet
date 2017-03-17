require 'rails_helper'

RSpec.describe OhSheet::ImportersController do
  routes { OhSheet::Engine.routes }

  describe 'POST import' do
    context 'with the right params' do
      let(:params) do
        {
          file_to_import: fixture_file_upload('contacts.xlsx')
        }
      end

      let(:process_id) { 1 }

      before do
        allow_any_instance_of(OhSheet::ImportProcess).to receive(:id)
          .and_return(process_id)
        allow(OhSheet::ImporterJob).to receive(:perform_later)
      end

      it 'returns a success response' do
        post :import, resource_name: 'foo', **params
        expect(response).to be_success
      end

      it 'calls the importer for the given resource_name' do
        expect(OhSheet::ImporterJob).to receive(:perform_later)
          .with('FooImporter', process_id)
        post :import, resource_name: 'foo', **params
      end
    end

    context 'with wrong type of file' do
      let(:params) do
        {
          file_to_import: fixture_file_upload('contacts.csv')
        }
      end

      it 'returns the error' do
        post :import, resource_name: 'foo', **params
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end

  end
end
