# frozen_string_literal: true

class PagesController < ApplicationController
  decorates_assigned :best_projects
  def index
    @best_projects = Project.best_projects.map(&:decorate)
  end
end
