# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@diy-plans.ru'
  layout 'mailer'
end
