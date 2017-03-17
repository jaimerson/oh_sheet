module OhSheet
  class ImporterJob < ApplicationJob
    def perform(resource_name, process_id)
      resource = resource_for(resource_name)
      parser = parser_for(resource_name)
      process = ImportProcess.find(process_id)

      Importer.new(process, resource: resource, parser: parser).import

      process.update(status: ImportProcess.statuses[:complete])
    end

    private

    def resource_for(name)
      name.camelize.constantize
    end

    def parser_for(name)
      camelized = name.camelize + 'Parser'
      camelized.constantize
    rescue NameError
      raise NameError, "You must define a #{camelized} class."
    end
  end
end
