# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/feedback_mailer
class FeedbackMailerPreview < ActionMailer::Preview
  def new_feedback
    FeedbackMailer.with(id: Feedback.last.id).new_feedback.deliver_now
  end
end
