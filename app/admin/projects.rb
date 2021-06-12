# frozen_string_literal: true

ActiveAdmin.register Project do
  # belongs_to :category
  # belongs_to :user

  permit_params :title, :short_description, :description, :price, :old_price, :cost_price, :dimentions, :difficulty,
                :materials, :status, :hit, :created_at, :updated_at, :category_id, :user_id, images: []

  index do
    selectable_column
    id_column
    column :title
    column :short_description
    column :description
    column :price
    column :old_price
    column :cost_price
    column :dimentions
    column :difficulty
    column :materials
    column :status
    column :hit
    column :created_at
    column :updated_at
    column :category
    column :user
    column 'Image' do |project|
      project.images.map(&:image_file_name).join('<br />').html_safe
    end
    # column :user.email
    # column :category.name
    actions
  end

  # filter :category.name
  # filter :user.email
  filter :status
  filter :difficulty

  form do |f|
    f.inputs do
      f.input :title
      f.input :short_description
      f.input :description
      f.input :price
      f.input :old_price
      f.input :cost_price
      f.input :dimentions
      f.input :difficulty
      f.input :materials
      f.input :status
      f.input :hit
      f.input :category
      f.input :user
      # f.input :user.email
      # f.input :category.name
      f.inputs do
        f.input :images, as: :file, input_html: { multiple: true }
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :images do
        div do
          project.images.each do |img|
            div do
              image_tag url_for(img), size: '100x100'
            end
          end
        end
      end

      row :content
      row :published
      row :title
      row :short_description
      row :description
      row :price
      row :old_price
      row :cost_price
      row :dimentions
      row :difficulty
      row :materials
      row :status
      row :hit
      row :created_at
    end
  end
end
