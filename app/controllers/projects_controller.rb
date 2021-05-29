# frozen_string_literal: true

class ProjectsController < ApplicationController
  PER_PAGE = 12
  before_action :set_categories, only: %i[index]

  def index
    @projects = Project.by_category(params[:category_id]).order(params[:sort])
    @projects = Projects::SortingAndFilteringQuery.call(@projects, params[:category_id], params[:sorting])
                                                  .page(params[:page])
                                                  .per(PER_PAGE)
                                                  .includes(%i[images_attachments user])
                                                  .decorate
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
