# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_categories, only: %i[index]

  def index
    @projects = Projects::SortingAndFilteringQuery.call(params[:category_id], params[:sorting]).decorate
  end

  def show
    @project = Project.find(params[:id]).decorate
  end

  private

  def set_categories
    @categories = Category.all
    @current_category_id = params[:category_id].to_i
  end
end
