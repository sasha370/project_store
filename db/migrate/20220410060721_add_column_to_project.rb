class AddColumnToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :vendor_code, :string
  end
end
