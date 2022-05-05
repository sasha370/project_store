# frozen_string_literal: true

require_relative '../../app/services/yandex_yml_generator_service'

desc 'Generate Yndex Market YML report'
task generate_report: :environment do
  YandexYmlGeneratorService.new.generate_fid
end
