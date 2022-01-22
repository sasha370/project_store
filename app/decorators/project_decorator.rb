# frozen_string_literal: true

class ProjectDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers

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

  def cart_buttons(for_catalog: false)
    @for_catalog = for_catalog
    return ask_register unless h.current_user

    already_in_cart = h.current_user.orders.cart.map(&:project_ids).flatten.include?(id)
    already_bought = h.current_user.orders.paid.map(&:project_ids).flatten.include?(id)

    return go_to_cart_button if already_in_cart

    return download_button if already_bought

    add_to_cart_button
  end

  private

  def download_button
    h.link_to '#', class: style_for_link do
      out = []
      out << h.tag.i('', class: "fa fa-download #{style_for_icon} mr-2", aria_hidden: true)
      out << add_text('Скачать')
      h.safe_join(out)
    end
  end

  def add_to_cart_button
    h.link_to add_to_cart_path(self), class: style_for_link, id: "add_to_cart_#{id}", remote: true do
      out = []
      out << h.tag.i('', class: "fa fa-shopping-cart #{style_for_icon}  mr-2", aria_hidden: true)
      out << add_text('Купить')
      h.safe_join(out)
    end
  end

  def go_to_cart_button
    h.link_to cart_path, class: style_for_link do
      out = []
      out << h.tag.i('', class: "fas fa-coins #{style_for_icon} mr-2", aria_hidden: true)
      out << add_text('В корзине')
      h.safe_join(out)
    end
  end

  def style_for_link
    @for_catalog ? 'thumb-hover-link' : 'btn btn-default pull-right general-position'
  end

  def style_for_icon
    'thumb-icon' if @for_catalog
  end

  def add_text(text)
    @for_catalog ? '' : text
  end

  def ask_register
    h.link_to new_user_session_path, class: style_for_link do
      out = []
      out << h.tag.i('', class: "fas fas fa-sign-in-alt #{style_for_icon} mr-2", aria_hidden: true)
      out << add_text('Войти')
      h.safe_join(out)
    end
  end
end
