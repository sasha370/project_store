# frozen_string_literal: true

module ApplicationHelper
  def format_date(date)
    date.strftime('%d/%m/%Y %R')
  end

  def user_avatar(user)
    image_tag(user.avatar.variant(:thumb)) if user.avatar.attached?
  end
end
