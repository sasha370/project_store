# frozen_string_literal: true

class Project < ApplicationRecord
  ActiveAdmin.register Project do
    permit_params do
      permitted = %i[title short_description description difficulty status price old_price dimentions materials]
      permitted << :other if params[:action] == 'create' && current_user.admin?
      permitted
    end
  end

  validates :title, :short_description, :description, :difficulty, :price, :status, presence: true
  belongs_to :category, counter_cache: true
  belongs_to :user

  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize: '100x100'
  end

  scope :by_category, ->(category_id = nil) { category_id ? where(category_id: category_id) : all }
end
