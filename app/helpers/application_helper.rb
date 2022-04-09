# frozen_string_literal: true

module ApplicationHelper
  def format_date(date)
    date.strftime('%d/%m/%Y %R')
  end

  def user_avatar(user)
    if user.avatar.attached?
      image_tag(user.avatar.variant(:thumb))
    end
  end
end
