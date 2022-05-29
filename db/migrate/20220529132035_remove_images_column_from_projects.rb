class RemoveImagesColumnFromProjects < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :images, :json
  end
end
