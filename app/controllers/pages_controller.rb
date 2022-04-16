# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @best_projects = Project.best_projects.map(&:decorate)
  end
end
