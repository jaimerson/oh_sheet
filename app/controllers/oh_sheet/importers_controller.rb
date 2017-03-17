module OhSheet
  class ImportersController < ApplicationController
    rescue_from 'ActionController::ParameterMissing' do |e|
      errors = [e.message]
      render json: errors, status: :unprocessable_entity
    end

    def import
      file = params.require(:file_to_import)
      ImporterJob.perform_later(importer_class_name, file.to_s)

      head :ok
    rescue => e
      render json: { errors: [e.message] }, status: :unprocessable_entity
    end

    private

    def importer_class_name
      params[:resource_name].camelize + 'Importer'
    end
  end
end
