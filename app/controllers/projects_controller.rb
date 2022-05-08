# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_categories, only: %i[index]

  def index
    @category = Category.find_by(id: params[:category_id])
    @projects = Projects::SortingAndFilteringQuery.call(params[:category_id], params[:sorting]).decorate
  end

  def show
    @project = Project.friendly.find(params[:id]).decorate
  end

  private

  def set_categories
    @categories = Category.all.friendly
    @current_category_id = params[:category_id].to_i
  end
end
