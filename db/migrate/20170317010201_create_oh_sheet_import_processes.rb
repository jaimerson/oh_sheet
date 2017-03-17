class CreateOhSheetImportProcesses < ActiveRecord::Migration
  def change
    create_table :oh_sheet_import_processes do |t|
      t.attachment :file
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end
  end
end
