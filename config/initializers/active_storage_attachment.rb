# frozen_string_literal: true

module ActiveStorageAttachmentList
  extend ActiveSupport::Concern

  included do
    acts_as_list scope: %i[record_id record_type name]
  end
end

Rails.configuration.to_prepare do
  ActiveStorage::Attachment.send :include, ActiveStorageAttachmentList
end
