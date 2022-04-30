# frozen_string_literal: true

class FeedbackMailer < ApplicationMailer
  def new_feedback
    @feedback = Feedback.includes(:user).find_by(id: params[:id])
    mail(to: @feedback.user.email, bcc: 'budka52@bk.ru', subject: t('mailer.feedback.title'))
  end
end
