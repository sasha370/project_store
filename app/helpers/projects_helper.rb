# frozen_string_literal: true

module ProjectsHelper
  def projects_sorting_options
    Projects::SortingAndFilteringQuery::SORTINGS.keys
  end
end
