module OhSheet
  class ImportersController < ApplicationController
    def import
      process = ImportProcess.new(file: params.require(:file_to_import))

      if process.save
        ImporterJob.perform_later(params.require(:resource_name), process.id)
        head :ok
      else
        render json: { errors: process.errors }, status: :unprocessable_entity
      end
    rescue => e
      render json: { errors: [e.message] }, status: :unprocessable_entity
    end

    private
  end
end
