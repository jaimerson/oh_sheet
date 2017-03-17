module OhSheet
  class ImportProcess < ActiveRecord::Base
    validates_presence_of :file
    has_attached_file :file
    validates_attachment_content_type :file,
      content_type: /\Aapplication\/vnd\.openxmlformats-officedocument\.spreadsheetml\.sheet\z/
  end
end
