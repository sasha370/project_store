# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def new_order
    @order = Order.includes(:projects).find_by(id: params[:id])&.decorate
    return unless @order

    @user = @order.user
    @order.update(notification_sent_at: Time.zone.now)
    mail(to: @user.email, subject: "Заказ #{@order.id} на сайте Diy-plans.ru")
  end
end
