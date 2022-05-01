class AddColumnSetDescriptionToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :set_description, :text
  end
end
