require 'rails_helper'

RSpec.describe OhSheet::ImporterJob do
  subject(:perform) { OhSheet::ImporterJob.new.perform(resource_name, process_id) }
  let(:filepath) { OhSheet::Engine.root.join('spec/fixtures/contacts.xlsx') }
  let(:file) { File.open(filepath, encoding: 'utf-8') }

  let(:process) do
    OhSheet::ImportProcess.create(file: file)
  end
  let(:process_id) { process.id }

  context 'when the resource and its parser are defined' do
    let(:resource_name) { 'foo' }

    Foo = Class.new
    FooParser = Class.new

    it 'initializes the importer with the resource' do
      importer = instance_double(OhSheet::Importer)

      expect(OhSheet::Importer).to receive(:new)
        .with(process, resource: Foo, parser: FooParser)
        .and_return(importer)

      expect(importer).to receive(:import)

      perform
    end
  end

  context 'when the resource is not defined' do
    let(:resource_name) { 'bar' }

    it 'raises an error' do
      expect { perform }.to raise_error(NameError)
    end
  end

  context 'when the parser is not defined' do
    let(:resource_name) { 'bar' }
    Bar = Class.new

    it 'raises an error' do
      expect { perform }
        .to raise_error(NameError, 'You must define a BarParser class.')
    end
  end

end
