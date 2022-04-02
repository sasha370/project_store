# frozen_string_literal: true

class YandexMoneyService
  BASE_URI = 'https://yoomoney.ru/quickpay/confirm'

  def initialize(payment_id)
    @payment = Payment.find(payment_id)
    @user = @payment.user
  end

  def checkout
    fill_in_payments
    # response = self.class.post BASE_URI, format: :xml, query: body
    body
  end

  private

  def fill_in_payments
    @payment.amount = @user.amount_with_discount
    @payment.metadata[:orders] = @user.orders.pluck(:id)
    @payment.save
  end

  def body
    @body ||= { receiver: '410011633433937',              # ID wallet
                'quickpay-form' => 'donate',              # donat
                paymentType: 'AC',                        # only card
                formcomment: 'diy-plans.ru',              # name inside a check
                targets: "Транзакция ##{@payment.id}",
                label: @payment.id,
                sum: @payment.amount,
                successURL: Rails.application.routes.url_helpers.my_orders_url }
  end
end
