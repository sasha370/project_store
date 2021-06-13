# frozen_string_literal: true

class PurchasmentsController < ApplicationController
  skip_forgery_protection only: :add_to_cart

  def add_to_cart
    respond_to do |format|
      format.js do
        if current_user
          @project = Project.find_by(id: params[:id].to_i)
          current_user.purchasments.create(project: @project)
          flash.now[:notice] = 'Project was succesfully add to cart'
        else
          flash.now[:error] = 'Something goes wrong'
        end
      end
    end
  end
end
