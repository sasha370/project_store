# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params do
    permitted = %i[email encrypted_password provider uid reset_password_token reset_password_sent_at
                   remember_created_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip
                   last_sign_in_ip confirmation_token confirmed_at confirmation_sent_at]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
