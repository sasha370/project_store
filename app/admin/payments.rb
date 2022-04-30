# frozen_string_literal: true

ActiveAdmin.register Payment do
  permit_params  :id, :status, :processed_at, :metadata, :order_id

  index do
    selectable_column
    id_column
    column :order
    tag_column :status
    column :operation_id
    column :processed_at
    column :metadata do |payment|
      tag.pre JSON.pretty_generate(payment.metadata)
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :order
      tag_row :status
      row :operation_id
      row :processed_at
      row :metadata do |payment|
        tag.pre JSON.pretty_generate(payment.metadata)
      end
      row :created_at
      row :updated_at
    end
  end

  #New and Edit form fields
  form do |f|
    f.inputs do
      f.input :order, as: :select, collection: Order.all.collect { |order| ["Заказ: #{order.id}", order.id] }
      f.input :metadata
      f.input :status
    end
    f.actions
  end
end
