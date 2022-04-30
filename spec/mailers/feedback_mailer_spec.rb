# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeedbackMailer, type: :mailer do
  let(:user) { create :user }
  let(:mail) { described_class.with(id: feedback.id).new_feedback.deliver_now }
  let(:feedback) { create :feedback, user: user }

  describe 'after payment confirmed' do
    it 'renders the subject' do
      expect(mail.subject).to eq(t('mailer.feedback.title'))
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([feedback.user.email])
      expect(mail.bcc).to eq(['budka52@bk.ru'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['info@diy-plans.ru'])
    end
  end
end
