# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  private

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
                                 :cover)
  end
end
