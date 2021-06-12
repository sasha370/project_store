# frozen_string_literal: true

class ProjectsController < ApplicationController
  PER_PAGE = 12
  before_action :set_categories, only: %i[index]

  def index
    @projects = Project.all
    @projects = Projects::SortingAndFilteringQuery.call(@projects, params[:category_id], params[:sorting])
                                                  .page(params[:page])
                                                  .per(PER_PAGE)
                                                  .includes(%i[user])
                                                  .decorate
  end

  def show
    @project = Project.includes(%i[user]).find(params[:id]).decorate
  end

  private

  def set_categories
    @categories = Category.all
  end

  # def project_params
  #   params.require(:project).permit(:id, :title, :price, :old_price, :description, :short_description, :dimentions,
  #                                   :materials, :cost_price, :status, :category_id, :hit)
  # end
end
