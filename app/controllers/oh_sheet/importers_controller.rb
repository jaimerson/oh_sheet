module OhSheet
  class ImportersController < ApplicationController
    rescue_from 'ActionController::ParameterMissing' do |e|
      errors = [e.message]
      render json: errors, status: :unprocessable_entity
    end

    def import
      file = params.require(:file_to_import)
      importer = importer_from_params.new(file)
      if importer.import
        head :ok
      else
        render json: { errors: importer.errors }, status: :unprocessable_entity
      end
    end

    private

    def importer_from_params
      importer_name = params[:resource_name].camelize + 'Importer'
      importer_name.constantize
    end
  end
end
