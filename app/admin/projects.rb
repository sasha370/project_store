# frozen_string_literal: true

ActiveAdmin.register Project do
  permit_params :authenticity_token, :id, :commit, :project, :title, :short_description, :description, :price, :old_price, :cost_price, :dimensions, :difficulty,
                :materials, :status, :hit, :created_at, :updated_at, :category_id, :user_id, {images: []}

  includes :category
  scope_to :current_user, unless: proc { current_user.admin? }

  scope :all
  scope :newest
  scope :approved
  scope :published

  action_item :publish, only: :show do
    link_to 'Publish', publish_admin_project_path(project), method: :put unless project.published?
  end

  action_item :publish, only: :show do
    link_to 'Unpublish', unpublish_admin_project_path(project), method: :put if project.published?
  end

  action_item :view, only: :show do
    link_to 'View on site', project_path(project) if project.published?
  end

  member_action :publish, method: :put do
    project = Project.find(params[:id])
    project.update(status: :published)
    redirect_to admin_project_path(project)
  end

  member_action :unpublish, method: :put do
    project = Project.find(params[:id])
    project.update(status: :approved)
    redirect_to admin_project_path(project)
  end

  member_action :destroy_image, method: :delete do
    project = Project.find(params[:id])
    index = params[:index].to_i

    remain_images = project.images.map(&:identifier)
    if index.zero? && project.images.size == 1
      project.remove_images!
    else
      deleted_image = remain_images.delete_at(index)
      deleted_image.try(:remove!)
      project.images = remain_images
    end
    project.save
    flash[:notice] = 'Image deleted!'
    redirect_to edit_admin_project_path(project)
  end

  controller do
    def update
      project = Project.find(params[:id])
      params[:project][:images].concat(project.images.map(&:identifier)).uniq if params[:project][:images]
      project.update(permitted_params[:project])
      flash[:notice] = 'Project Updated!'
      redirect_to edit_admin_project_path(project)
    end
  end

  index do
    selectable_column
    id_column
    column :title do |project|
      link_to project.title, admin_project_path(project)
    end
    column 'Short description' do |project|
      project.short_description.truncate(30)
    end
    column 'Description' do |project|
      project.description.truncate(30)
    end
    column :price do |project|
      number_to_currency project.price
    end
    column :old_price do |project|
      number_to_currency project.old_price
    end

    tag_column :status
    bool_column :hit
    column :created_at
    column :category
    column 'Image' do |project|
      project.images.count
    end
    actions
  end

  filter :price, as: :numeric_range_filter
  filter :status, as: :numeric_range_filter
  filter :difficulty, as: :numeric_range_filter
  filter :category
  filter :hit

  form do |f|
    columns do
      column max_width: "50%" do
        panel 'Project' do
          f.inputs do
            f.input :title
            f.input :short_description
            f.input :description
            f.input :price
            f.input :old_price
            f.input :cost_price
            f.input :dimensions
            f.input :difficulty
            f.input :materials
            f.input :status
            f.input :category, as: :select, collection: Category.all.collect { |category| [category.title, category.id] }
            f.input :hit
          end
        end
      end
      column max_width: "50%" do
        panel 'Images' do
          f.inputs do
            f.input :images, as: :file, input_html: {multiple: true}
            if f.object.images.any?

              f.object.images.each.with_index do |img, index|
                span do
                  image_tag(img.thumb.url)
                end
                # link_to 'Delete', admin_project_image_path(project_id: project.id, id: index), "data-method": :delete,
                #                                                                                "data-confirm": 'Are you sure?', remote: true
                link_to 'Delete', destroy_image_admin_project_path(id: project.id, index: index), "data-method": :delete,
                        "data-confirm": 'Are you sure?'
              end
            end
          end
        end
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :images do
        columns do
          project.images.each do |img|
            column do
              image_tag img.url, size: '100x100'
            end
          end
        end
      end
      row :category
      row :title
      row :short_description
      row :description
      row :price do |project|
        number_to_currency project.price
      end
      row :old_price do |project|
        number_to_currency project.old_price
      end
      row :cost_price
      row :dimensions
      row :difficulty
      row :materials
      tag_row :status
      tag_row :hit
      row :created_at
      row :updated_at
    end
  end
end
