# frozen_string_literal: true

class PaymentsController < ApplicationController
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
    @payment.metadata[:purchasments] = @user.purchasments.pluck(:id)
    @payment.save
  end
end
