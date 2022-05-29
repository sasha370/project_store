# frozen_string_literal: true

require "image_processing/mini_magick"

ActiveAdmin.register Project do
  include Rails.application.routes.url_helpers
  permit_params :authenticity_token, :id, :commit, :project, :title, :short_description, :description, :price, :old_price, :dimensions, :difficulty,
                :status, :hit, :created_at, :updated_at, :category_id, :user_id, {images: []}, :archive, :vendor_code, :set_description, :position

  includes :category, :archive_attachment

  controller do
    def scoped_collection
      Project.unscoped
    end
  end

  #Index sort buttons
  scope :all
  scope :unpublished
  scope :published

  #Index filters
  filter :title
  filter :price, as: :numeric_range_filter
  filter :status, as: :numeric_range_filter
  filter :difficulty, as: :numeric_range_filter
  filter :vendor_code
  filter :category
  filter :hit

  controller do
    def update
      project = Project.friendly.find(params[:id])

      images = params[:project][:images]
      if images
        images.each do |image|
          tempfile = ImageProcessing::MiniMagick.source(image.tempfile.path).resize_to_fill(nil, 768).call
          image.tempfile = tempfile
        end
      end
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
    column :price
    column :old_price

    tag_column :status
    bool_column :hit
    column :vendor_code
    # column :created_at
    column :category
    column 'Image' do |project|
      project.images.count
    end
    column :archive do |project|
      if project.archive.attached?
        link_to 'File', project.decorate.archive_link
      else
        'no_file'
      end
    end
    actions
  end

  show do
    attributes_table do
      row :images do
        columns do
          project.images.each do |img|
            column do
              image_tag img, size: '100x100'
            end
          end
        end
      end
      row :archive do
        columns do
          column do
            if project.archive.attached?
              link_to project.archive.blob.filename, project.decorate.archive_link
            else
              'no_file'
            end
          end
        end
      end
      row :category
      row :title
      row :short_description
      row :description
      row :short_description
      row :price do |project|
        number_to_currency project.price
      end
      row :old_price do |project|
        number_to_currency project.old_price
      end
      row :vendor_code
      row :slug
      row :dimensions
      row :difficulty
      tag_row :status
      tag_row :hit
      row :created_at
      row :updated_at
      row 'Кол-во покупок' do |project|
        OrderProject.where(project_id: project).count
      end
      row :orders
    end
  end

  #New and Edit form fields
  form do |f|
    columns do
      column max_width: "50%" do
        panel 'Project' do
          # row :vendor_code
          f.inputs do
            li do
              link_to 'Preview', project_path(@resource), target: '_blank', class: 'action_item' unless @resource.new_record?
            end
            f.input :title
            f.input :vendor_code
            f.input :short_description
            f.input :description, as: :quill_editor
            f.input :set_description, as: :quill_editor
            f.input :price
            f.input :old_price
            f.input :dimensions
            f.input :difficulty
            f.input :status
            f.input :category, as: :select, collection: Category.all.friendly.collect { |category| [category.title, category.id] }
            f.input :hit
          end
        end
      end
      column max_width: "50%" do
        panel 'Images' do
          f.inputs do
            f.input :images, as: :file, input_html: {multiple: true}
            ul do
              if f.object.images.any?
                f.object.images.order(position: :asc).each.with_index do |img, index|
                  li do
                    span do
                      image_tag img.variant(:thumb)
                    end

                    div "Размеры: #{img.metadata['width']}x#{img.metadata['height']}"
                    div "Позиция: #{img.position}"
                    link_to 'Up  ', move_up_admin_project_path(img_id: img.id)
                    link_to 'Down  ', move_down_admin_project_path(img_id: img.id)
                    link_to 'Delete', destroy_image_admin_project_path(img_id: img.id), "data-method": :delete,
                            "data-confirm": 'Are you sure?', class: 'btn btn-primary'
                    div '-' * 50
                  end
                end
              end
            end
          end
          f.actions
        end
        panel 'Files' do
          span do
            link_to f.object.archive.blob.filename, rails_blob_url(f.object.archive), target: "_blank" if object.archive.attached?
          end
          span do
            f.input :archive, as: :file, input_html: {multiple: false}
          end
        end
      end
    end
    f.actions
  end

  # Publish Project button
  action_item :publish, only: :show do
    link_to 'Publish', publish_admin_project_path(project), method: :put unless project.published?
  end

  member_action :publish, method: :put do
    project = Project.friendly.find(params[:id])
    project.update(status: :published)
    redirect_to admin_project_path(project)
  end

  # Unpublish Project button
  action_item :unpublish, only: :show do
    link_to 'Unpublish', unpublish_admin_project_path(project), method: :put if project.published?
  end

  member_action :unpublish, method: :put do
    project = Project.friendly.find(params[:id])
    project.update(status: :unpublished)
    redirect_to admin_project_path(project)
  end

  # Redirect to Project page button
  action_item :view, only: :show do
    link_to 'View on site', project_path(project) if project.published?
  end

  # Destroy one of project images
  member_action :destroy_image, method: :delete do
    image = ActiveStorage::Attachment.find(params[:img_id])
    image.purge
    flash[:notice] = 'Image deleted!'
    redirect_to edit_admin_project_path(resource)
  end

  member_action :move_up, method: :get do
    image = ActiveStorage::Attachment.find(params[:img_id])
    image.move_higher
    redirect_to edit_admin_project_path(resource)
  end

  member_action :move_down, method: :get do
    image = ActiveStorage::Attachment.find(params[:img_id])
    image.move_lower
    redirect_to edit_admin_project_path(resource)
  end
end
