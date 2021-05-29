# frozen_string_literal: true

module ProjectsHelper
  def category_filter_placeholder(categories, params)
    category = categories.find_by(id: params[:category_id]) || categories.first
    category.title
  end

  def projects_sorting_options
    Projects::SortingAndFilteringQuery::SORTINGS.keys
  end
end
