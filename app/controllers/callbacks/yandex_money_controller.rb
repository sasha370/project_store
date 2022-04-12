# frozen_string_literal: true

# https://yoomoney.ru/transfer/myservices/http-notification?_openstat=settings%3Bother%3Bmoney%3Bhttp%3Bset

module Callbacks
  class YandexMoneyController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }
    around_action :log_everything, only: :perform

    def perform
      return head :unauthorized unless correct_sender?
      return head :bad_request unless payment && correct_amount?

      # TODO. Move all update logic to separate Worker
      update_payment
      head :ok
    end

    private

    def correct_sender?
      sha1 = Digest::SHA1.hexdigest(process_params)
      parsed_data[:sha1_hash] == sha1
    end

    def update_payment
      payment.update(
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
      payment.amount.to_i == parsed_data[:amount].to_i
    end

    def logger
      @logger ||= Logger.new(Rails.root.join('log/yandex_callbacks.log'))
    end

    def log_everything
      log_headers
      yield
    ensure
      log_response
    end

    def log_headers
      http_envs = {}.tap do |envs|
        request.headers.each do |key, value|
          envs[key] = value if key.downcase.starts_with?('http')
        end
      end

      logger.info "<<<<<<<<<\n" \
                  "Received #{request.method.inspect} to #{request.url.inspect} from" \
                  "#{request.remote_ip.inspect}.\n" \
                  "Processing with headers #{http_envs.inspect} and params #{params.inspect}"
    end

    def log_response
      logger.info ">>>>>>>>>\n" \
                  "Responding with #{response.status.inspect} => #{response.body.inspect}"
    end
  end
end
