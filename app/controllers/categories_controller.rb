# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    @books = Book.all
    render :show
  end

  def show
    @books = Category.find(params[:id]).books
  end
end
