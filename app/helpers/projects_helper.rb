# frozen_string_literal: true

module ProjectsHelper
  def projects_sorting_options
    Projects::SortingAndFilteringQuery::SORTING_TYPES.keys
  end
end
