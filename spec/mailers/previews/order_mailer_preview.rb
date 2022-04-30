# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def new_order
    OrderMailer.with(id: Order.first.id).new_order.deliver_now
  end
end
