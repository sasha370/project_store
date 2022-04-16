# frozen_string_literal: true

class ProjectDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  # include Draper::LazyHelpers

  delegate_all
  MAX_TITLE_LENGTH = 27

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def short_title
    title.truncate(MAX_TITLE_LENGTH, separator: /\s/)
  end

  def images_for_gallery
    images.map do |image|
      { original: image.url, thumbnail: image.thumb.url }
    end
  end

  def cart_buttons
    return ask_register(for_catalog: false) unless h.current_user

    return go_to_cart_button(for_catalog: false) if already_in_cart

    return download_button(for_catalog: false) if already_bought

    add_to_cart_button(for_catalog: false)
  end

  def cart_buttons_catalog
    return download_button if already_bought

    go_to_cart_button if already_in_cart
  end

  private

  def already_bought
    h.current_user.orders.paid.map(&:project_ids).flatten.include?(id) if h.current_user
  end

  def already_in_cart
    h.current_user.orders.cart.map(&:project_ids).flatten.include?(id) if h.current_user
  end

  def download_button(for_catalog: true)
    h.link_to download_project_path(self), class: style_for_link(for_catalog) do  # TODO, create download link
      h.tag.i(for_catalog ? '' : ' Скачать', class: 'fa fa-download', aria_hidden: true)
    end
  end

  def add_to_cart_button(for_catalog: true)
    h.link_to add_to_cart_path(self), class: style_for_link(for_catalog), id: "add_to_cart_#{id}", remote: true do
      h.tag.i(' Купить', class: 'fa fa-shopping-cart', aria_hidden: true)
    end
  end

  def go_to_cart_button(for_catalog: true)
    h.link_to cart_path, class: style_for_link(for_catalog) do
      h.tag.i(add_text(' В корзине', for_catalog), class: 'fas fa-coins', aria_hidden: true)
    end
  end

  def ask_register(for_catalog: true)
    h.link_to new_user_session_path, class: style_for_link(for_catalog) do
      h.tag.i(' Войти', class: 'fas fas fa-sign-in-alt', aria_hidden: true)
    end
  end

  def style_for_link(for_catalog)
    for_catalog ? 'thumb-hover-link thumb-icon' : 'btn btn-default pull-right general-position'
  end

  def add_text(text, for_catalog)
    for_catalog ? '' : text
  end
end
