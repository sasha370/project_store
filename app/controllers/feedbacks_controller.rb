# frozen_string_literal: true

class FeedbacksController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      # TODO: , отправить письма
      flash[:notice] = t('alerts.feedback')
      redirect_to root_path
    else
      flash.now[:notice] = t('errors.feedback')
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:title, :body, :user_id)
  end
end
