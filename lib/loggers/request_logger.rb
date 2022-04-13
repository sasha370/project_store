# frozen_string_literal: true

module Loggers
  class RequestLogger
    delegate :info, :debug, :warn, :error, to: :@logger

    def initialize(service_name)
      @logger = Logger.new(get_log_file(service_name))
    end

    def log_request(request)
      @logger.info "<<<<<<<<<\n" \
                "Received #{request.method.inspect} to #{request.url.inspect} from" \
                "#{request.remote_ip.inspect}.\n" \
                "Params #{JSON.pretty_generate(request.request_parameters)}"
    end

    def log_response(response)
      @logger.info ">>>>>>>>>  Responding with #{response.status.inspect} => #{response.body.inspect}\n"
    end

    private

    def get_log_file(service_name)
      directory_name = Rails.root.join("log/#{service_name}")
      Dir.mkdir(directory_name) unless File.exist?(directory_name)

      file_path = "#{directory_name}/#{Time.zone.today}.log"
      File.new(file_path, 'a')
    end
  end
end
