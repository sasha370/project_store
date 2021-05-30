# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @best_projects = Project.all.limit(4).includes(%i[images_attachments user]).decorate
  end
end
