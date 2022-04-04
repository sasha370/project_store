# frozen_string_literal: true

module Callbacks
  class YandexMoneyController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }

    before_action :authenticate_sender, only: [:perform]

    def perform
      update_payment
    end

    private

    def authenticate_sender
      sha1 = Digest::SHA1.hexdigest(process_params)
      head :unauthorized unless parsed_data[:sha1_hash] == sha1
    end

    def update_payment
      @payment = Payment.find_by(id: parsed_data[:label])
      return head :bad_request unless @payment

      @payment&.update(
        processed_at: parsed_data[:datetime],
        operation_id: parsed_data[:operation_id],
        status: :paid
      )
      @payment.order.update(status: :paid)
      head :ok
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
  end
end
