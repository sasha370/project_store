# frozen_string_literal: true

# Clean up guests from DB with cart
class GuestsCleanupJob
  include Sidekiq::Job

  THRESHOLD_DAYS = 7

  def perform
    guests = User.guest.where('created_at < ?', THRESHOLD_DAYS.days.ago)
    guests.in_batches.delete_all
  end
end
