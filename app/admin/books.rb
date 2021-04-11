# frozen_string_literal: true

ActiveAdmin.register Book do
  permit_params do
    permitted = %i[title author price quantity description published_year dimentions materials]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
