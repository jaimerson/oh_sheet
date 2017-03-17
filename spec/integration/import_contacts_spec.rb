require 'rails_helper'

RSpec.describe OhSheet::ImportersController, type: :controller do
  routes { OhSheet::Engine.routes }

  describe 'POST /oh_sheet/import/contact' do
    let(:params) do
      {
        file_to_import: fixture_file_upload('contacts.xlsx')
      }
    end

    it 'imports contacts' do
      expect { post :import, resource_name: 'contact', **params }
        .to change(Contact, :count).by(12)
    end
  end
end
