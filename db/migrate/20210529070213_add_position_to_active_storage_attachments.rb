class AddPositionToActiveStorageAttachments < ActiveRecord::Migration[6.1]
  def change
    add_column :active_storage_attachments, :position, :integer, default: 0
  end
end
