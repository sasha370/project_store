# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def checkout
    @payment = Payment.find(params[:id])
    @user = @payment.user
    fill_in_payments
    respond_to do |format|
      format.js
    end
  end

  def fill_in_payments
    @payment.amount = @user.amount_with_discount
    @payment.metadata[:orders] = @user.orders.pluck(:id)
    @payment.save
  end
end
