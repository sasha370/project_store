# frozen_string_literal: true

module Projects
  # Filters and sorts projects for Index page
  class SortingAndFilteringQuery < BaseQuery
    SORTING_TYPES = {
      newest: 'created_at desc',
      oldest: 'created_at asc',
      price_asc: 'price asc',
      price_desc: 'price desc'
    }.freeze
    DEFAULT_SORTING = 'newest'

    def initialize(category_id, sorting, projects: nil)
      @projects = projects || Project.published.includes(images_attachments: :blob)
      @category_id = category_id
      @sorting = sorting || DEFAULT_SORTING
    end

    def call
      @projects.friendly
      filter_projects
      order_projects
    end

    private

    def filter_projects
      @projects = @projects.where(category_id: @category_id) if @category_id
    end

    def order_projects
      @projects.order(SORTING_TYPES[@sorting.to_sym])
    end
  end
end
