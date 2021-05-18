# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_categories, only: %i[index]
  PER_PAGE = 12

  def index
    @projects = Project.by_category(params[:category_id]).order(params[:sort])
    @projects = @projects.paginate(page: params[:page],
                                   per_page: PER_PAGE)
  end

  def show
    @project = Project.find(params[:id])
  end

  private

  def set_categories
    @categories = Category.all
  end

  def project_params
    params.require(:project).permit(:id,
                                    :title,
                                    :price,
                                    :old_price,
                                    :description,
                                    :short_description,
                                    :dimentions,
                                    :materials,
                                    :cover,
                                    :status,
                                    :sort,
                                    :category_id)
  end
end
