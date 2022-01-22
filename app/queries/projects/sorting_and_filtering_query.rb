# frozen_string_literal: true

module Projects
  # Filters and sorts projects for Index page
  class SortingAndFilteringQuery < BaseQuery
    SORTING_TYPES = {
      newest: 'created_at desc',
      price_asc: 'price asc',
      price_desc: 'price desc',
      popular: nil
    }.freeze

    def initialize(projects, category_id, sorting)
      @projects = projects
      @category_id = category_id
      @sorting = sorting
    end

    def call
      filter_projects
      order_projects
    end

    private

    def filter_projects
      @projects = @projects.where(category_id: @category_id) if @category_id
    end

    def order_projects
      return @projects unless @sorting

      @projects.order(SORTING_TYPES[@sorting.to_sym])
    end
  end
end
