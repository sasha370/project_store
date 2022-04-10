# frozen_string_literal: true

class ProjectsController < ApplicationController
  PER_PAGE = 12
  before_action :set_categories, only: %i[index]

  def index
    @projects = Project.all
    @projects = Projects::SortingAndFilteringQuery.call(@projects, params[:category_id], params[:sorting])
                                                  .page(params[:page])
                                                  .per(PER_PAGE)
                                                  .decorate
  end

  def show
    @project = Project.find(params[:id]).decorate
  end

  private

  def set_categories
    @categories = Category.all
    @current_category_id = params[:category_id].to_i
  end

  # def project_params
  #   params.require(:project).permit(:id, :title, :price, :old_price, :description, :short_description, :dimensions,
  #                                   :materials, :cost_price, :status, :category_id, :hit)
  # end
end
