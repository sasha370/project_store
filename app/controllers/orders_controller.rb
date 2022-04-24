# frozen_string_literal: true

class OrdersController < ApplicationController
  skip_forgery_protection only: %i[add_to_cart remove_from_cart]
  before_action :authenticate_user!, :find_cart
  include ActionView::Helpers::NumberHelper

  def add_to_cart
    respond_to do |format|
      format.js do
        @project = Project.friendly.find(params[:id])
        @cart.order_projects.find_or_create_by(project_id: @project.id)
        flash.now[:notice] = 'Project was successfully add to cart'
      end
    end
  end

  def cart
    @cart = current_user.cart
    @order_projects = @cart.order_projects.includes([:project])
    @payment = @cart.payment || @cart.create_payment!
  end

  def remove_from_cart
    respond_to do |format|
      format.js do
        @order_project = OrderProject.find(params[:id])
        @order_project.destroy
        flash.now[:notice] = 'Project was removed from cart'
      end
    end
  end

  private

  def find_cart
    @cart = current_user.orders.cart.first_or_create
  end
end
