class AddImagesToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :images, :json
  end
end
