# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :id, :title, :description, :created_at, :updated_at, :projects_count

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :created_at
    column :updated_at
    column :projects_count
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :created_at
      row :updated_at
      row :projects do |category|
        table_for category.projects do
          column "Проекты" do |project|
            link_to project.title, admin_project_path(project)
          end
        end
      end
    end
    active_admin_comments
  end
end
