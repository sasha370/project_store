# frozen_string_literal: true

ActiveAdmin.register Feedback do
  permit_params  :id, :title, :body, :user_id

  #New and Edit form fields
  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.all.collect { |user| [user.email, user.id] }
      f.input :title
      f.input :body
      f.input :created_at, input_html: { disabled: true }
    end
    f.actions
  end
end
