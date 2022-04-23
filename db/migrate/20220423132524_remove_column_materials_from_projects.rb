class RemoveColumnMaterialsFromProjects < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :materials
    remove_column :projects, :cost_price
  end
end
