# frozen_string_literal: true

class PurchasmentsController < ApplicationController
  skip_forgery_protection only: %i[add_to_cart remove_from_cart]

  def add_to_cart
    respond_to do |format|
      format.js do
        return (flash.now[:error] = 'Something goes wrong') unless current_user

        @project = Project.find_by(id: params[:id].to_i)
        current_user.purchasments.create(project: @project, price: @project.price)
        flash.now[:notice] = 'Project was succesfully add to cart'
      end
    end
  end

  def cart
    if current_user
      @payment = current_user.payments.empty.first_or_create
      @purchasments = current_user.purchasments.in_cart.includes(:project)
    else
      redirect_to root_path, notice: 'You need to be authorized'
    end
  end

  def remove_from_cart
    return unless (@purchasment = Purchasment.find(params[:id]))

    respond_to do |format|
      format.js do
        @purchasment.destroy
        flash.now[:notice] = 'Project was removed from cart'
      end
    end
  end
end
