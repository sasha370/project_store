# frozen_string_literal: true

RSpec.describe GuestsCleanupJob, type: :worker do
  include ActiveJob::TestHelper

  subject(:job) { described_class.new.perform }

  describe 'it remove all guest' do
    before do
      create_list(:user, 5, created_at: (GuestsCleanupJob::THRESHOLD_DAYS + 1).days.ago, guest: true)
      create(:user, guest: true)
    end

    it 'that older than THRESHOLD_DAYS' do
      expect { job }.to change(User, :count).by(-5)
    end
  end
end
