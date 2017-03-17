module OhSheet
  class Importer
    attr_reader :resource, :parser

    def initialize(process, resource:, parser:)
      @process = process
      @resource = resource
      @parser = parser
    end

    def import
      headers = rows.first.values

      rows.drop(1).each do |row|
        raw_params = headers.product(row.values).to_h
        attributes = parser.new(raw_params).attributes
        resource.create!(attributes)
      end
    end

    private

    def rows
      @rows ||= book.sheets.first.rows
    end

    def book
      @book ||= begin
        if @process.file.url.starts_with? '/system'
          Creek::Book.new(@process.file.path)
        else
          Creek::Book.new(@process.file.url, remote: true)
        end
      end
    end
  end
end
