# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :first_name, :last_name

  #Index filters
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  index do
    selectable_column
    id_column
    column :email do |user|
      link_to user.email, admin_user_path(user)
    end
    column :first_name
    column :last_name
    column 'Orders' do |user|
      link_to user.orders.count, admin_user_path(user)
    end
    tag_column :confirmed?
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
                user_avatar(user)
              end
            end
          end
          row :role
          row :email
          row :first_name
          row :last_name
          row :phone
          row :confirmed?
        end
      end
      column  max_width: "50%" do
        attributes_table 'Регистрационные данные' do
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

  #Sidebar for Show page
  sidebar 'Users Orders', only: %i[show] do
    ul do
      "Заказов #{resource.orders.count}. На сумму: #{number_to_currency resource.orders.sum(:amount)}"
    end
    ul do
      resource.orders.each do |order|
        li link_to "##{order.id} | Сумма: #{number_to_currency order.amount}", admin_order_path(order)
      end
    end
  end

  #New and Edit form fields
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

  # Confirm user email manually button
  member_action :confirm, method: :get do
    user = User.find(params[:id])
    user.confirm
    user.save
    redirect_to admin_user_path(user)
  end

  action_item :confirm, only: :show do
    link_to 'Confirm e-mail', confirm_admin_user_path(resource), method: :get unless resource.confirmed?
  end
end
