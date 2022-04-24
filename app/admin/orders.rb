# frozen_string_literal: true

ActiveAdmin.register Order do
  permit_params  :id, :status, :amount, :promocode, :discount, :user_id
  includes(:user, :payment)

  #Index sort buttons
  scope :all
  scope :paid
  scope :cart

  index do
    selectable_column
    id_column
    actions
    tag_column :status
    column :amount do |order|
      number_to_currency order.amount
    end
    column :discount
    column 'Item count' do |order|
      order.projects.count
    end
    column "Promocode" do |promocode|
      # link_to promocode.name, admin_promocode_path(promocode) #TDOD
    end
    column :payment
    column :user
    column :created_at
    column :updated_at
  end

  show do
    attributes_table do
      row :status do |order|
        status_tag order.status
      end
      row :amount do |order|
        number_to_currency order.amount
      end
      row :promocode
      row :discount
      row :payment
      row :projects do |order|
        table_for order.projects do
          column "Проект" do |project|
            link_to project.title, admin_project_path(project)
          end
          column "Цена" do |project|
            number_to_currency project.price
          end
        end
      end
      row :user
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
