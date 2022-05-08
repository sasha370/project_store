# frozen_string_literal: true

class OrdersController < ApplicationController
  skip_forgery_protection only: %i[add_to_cart remove_from_cart]
  before_action :find_cart
  include ActionView::Helpers::NumberHelper

  def add_to_cart
    respond_to do |format|
      format.js do
        @project = Project.friendly.find(params[:id])
        @cart.order_projects.find_or_create_by(project_id: @project.id)
        flash.now[:notice] = t('orders.success')
      end
    end
  end

  def cart
    @order_projects = @cart.order_projects.includes([:project])
    @payment = @cart.payment || @cart.create_payment!
  end

  def remove_from_cart
    @order_project = OrderProject.find(params[:id])
    @order_project.destroy

    # JS Turned OFF because it cannot works with number_to_currency
    respond_to do |format|
      format.js { flash.now[:notice] = t('orders.removed') }
      format.html do
        flash[:notice] = t('orders.removed')
        redirect_to cart_path
      end
    end
  end

  private

  def find_cart
    @cart = current_or_guest_user.cart
  end
end
