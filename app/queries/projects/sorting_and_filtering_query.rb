# frozen_string_literal: true

module Projects
  class SortingAndFilteringQuery < BaseQuery
    SORTINGS = {
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
      @projects = @category_id ? @projects.where(category_id: @category_id) : @projects
    end

    def order_projects
      return @projects unless @sorting

      @projects.order(SORTINGS[@sorting.to_sym])
    end
  end
end
