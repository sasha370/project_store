# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :first_name, :last_name

  sidebar 'Users Orders', only: %i[show],  max_width: "100%" do
    ul do
      resource.orders.each do |order|
        li link_to "##{order.id} | Сумма: #{order.amount}", admin_order_path(order)
      end
    end
  end

  index do
    selectable_column
    index_column
    column :email do |user|
      link_to user.email, admin_user_path(user)
    end
    column :first_name
    column :last_name
    column 'Orders' do |user|
      link_to user.orders.count, admin_user_path(user)
    end
    column :created_at
    column :sign_in_count
    column :current_sign_in_at
    actions
  end

  show do
    columns do
      column max_width: "50%" do

        attributes_table do
          row "Avatar" do |user|
            columns do
              column do
                # image_tag(user.avatar.thumb.url) #TODO
                # image_tag user.avatar.url, size: '100x100' if user.avatar
              end
            end
          end

          row :role
          row :email
          row :first_name
          row :last_name
          row :phone
          row :provider
          row :reset_password_sent_at
          row :sign_in_count
          row :current_sign_in_at
          row :last_sigh_in_at
          row :confirmed_at
          row :confirmation_sent_at
          row :unconfirmed_email
          row :created_at
          row :updated_at
        end
      end
    end
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
