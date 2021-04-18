# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_categories, only: %i[index]
  PER_PAGE = 12

  def index
    @books = Book.by_category(params[:category_id]).order(params[:sort])
    @books = @books.paginate(page: params[:page],
                             per_page: PER_PAGE)
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def set_categories
    @categories = Category.all
  end

  def book_params
    params.require(:book).permit(:id,
                                 :title,
                                 :author,
                                 :price,
                                 :quantity,
                                 :description,
                                 :published_year,
                                 :dimentions,
                                 :materials,
                                 :cover,
                                 :sort,
                                 :category_id)
  end
end
