# frozen_string_literal: true

module ApplicationHelper
  def categories_list
    all_books + books_by_category
  end

  private

  def all_books
    "<li class='mr-35'>#{link_to t('.all'), categories_path, class: 'filter-link mr-5'}
    <span class='badge general-badge'>#{Book.all.size}</span>  </li>"
  end

  def books_by_category
    data = ''
    Category.all.map do |category|
      data += "<li class='mr-35'>#{link_to category.title, category, class: 'filter-link mr-5'}
              <span class='badge general-badge'>#{category.books_count}</span></li>"
    end
    data
  end
end
