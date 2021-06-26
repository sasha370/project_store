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
    @payment.metadata[:purchasments] = @user.purchasments.pluck(:id)
    @payment.save
  end

  def body
    @body ||= { receiver: '410011633433937',              # ID кошелька
                'quickpay-form' => 'donate',              # донат или small для кнопки
                paymentType: 'AC',                        # только картой
                formcomment: 'diy-plans.ru',              # как отобразится у клиента в банковской выписке
                targets: "Транзакция ##{@payment.id}",
                label: @payment.id,
                sum: @payment.amount,
                successURL: Rails.application.routes.url_helpers.my_purchasments_url }
  end
end
