module OhSheet
  class ImportProcess < ActiveRecord::Base
    validates_presence_of :file
    has_attached_file :file
    validates_attachment_content_type :file,
      content_type: /(openxmlformats-officedocument|application\/zip)/
  end
end
