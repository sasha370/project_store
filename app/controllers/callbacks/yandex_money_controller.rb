# frozen_string_literal: true

# https://yoomoney.ru/transfer/myservices/http-notification?_openstat=settings%3Bother%3Bmoney%3Bhttp%3Bset
require_relative '../../../lib/loggers/request_logger'

# API class to process YM webhook
module Callbacks
  class YandexMoneyController < ActionController::API
    around_action :log_everything, only: :perform

    def perform
      return head :unauthorized unless correct_sender?
      return head :bad_request unless correct_amount?

      update_payment
      OrderMailer.with(id: payment.order.id).new_order.deliver_later

      head :ok
    end

    private

    def correct_sender?
      sha1 = Digest::SHA1.hexdigest(process_params)
      parsed_data[:sha1_hash] == sha1
    end

    def update_payment
      payment.update!(
        processed_at: parsed_data[:datetime],
        operation_id: parsed_data[:operation_id],
        metadata: parsed_data,
        status: :paid
      )
      payment.order.paid!
    end

    def parsed_data
      @parsed_data ||= request.request_parameters
    end

    def process_params # rubocop:disable Metrics/MethodLength
      [
        parsed_data[:notification_type],
        parsed_data[:operation_id],
        format('%.2f', parsed_data[:amount]),
        parsed_data[:currency],
        parsed_data[:datetime],
        parsed_data[:sender],
        parsed_data[:codepro],
        Rails.application.credentials[:ym_secret_key],
        parsed_data[:label]
      ].join('&').force_encoding('UTF-8')
    end

    def payment
      @payment ||= Payment.find_by(id: parsed_data[:label])
    end

    def correct_amount?
      status = (payment.amount.to_i == parsed_data[:withdraw_amount].to_i)
      log_amount(status, payment.amount.to_i, parsed_data[:withdraw_amount].to_i)
      status
    end

    def log_amount(status, in_payment, in_request)
      logger.warn "Amount is #{status ? 'correct' : 'incorrect!'} (#{in_payment}:#{in_request})"
    end

    def logger
      @logger ||= Loggers::RequestLogger.new('yandex_money')
    end

    def log_everything
      logger.log_request(request)
      yield
    ensure
      logger.log_response(response)
    end
  end
end
