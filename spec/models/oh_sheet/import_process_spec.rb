require 'rails_helper'

module OhSheet
  RSpec.describe ImportProcess, type: :model do
    it 'validates presence of file' do
      expect(ImportProcess.new(file: nil)).not_to be_valid
    end
  end
end
