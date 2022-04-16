# frozen_string_literal: true

class ProjectDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  include Draper::LazyHelpers

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
    return ask_register(for_catalog: false) unless current_user

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
    current_user.orders.paid.map(&:project_ids).flatten.include?(id) if current_user
  end

  def already_in_cart
    current_user.orders.cart.map(&:project_ids).flatten.include?(id) if current_user
  end

  def download_button(for_catalog: true) # rubocop:disable Metrics/MethodLength
    if archive.attached?
      link_to rails_blob_path(archive, disposition: 'attachment'), class: style_for_link(for_catalog) do
        tag.i(for_catalog ? '' : ' Скачать', class: 'fa fa-download', aria_hidden: true)
      end
    else
      # TODO, отправлять на форму обратной связи
      link_to '#', class: style_for_link(for_catalog) do
        tag.i(for_catalog ? '' : 'Файл не найден!',
              class: 'fa fa-download',
              aria_hidden: true,
              title: 'Файл не найден! Пожалуйста обратитесь в службу поддержки')
      end
    end
  end

  def add_to_cart_button(for_catalog: true)
    link_to add_to_cart_path(self), class: style_for_link(for_catalog), id: "add_to_cart_#{id}", remote: true do
      tag.i(' Купить', class: 'fa fa-shopping-cart', aria_hidden: true)
    end
  end

  def go_to_cart_button(for_catalog: true)
    link_to cart_path, class: style_for_link(for_catalog) do
      tag.i(add_text(' В корзине', for_catalog), class: 'fas fa-coins', aria_hidden: true)
    end
  end

  def ask_register(for_catalog: true)
    link_to new_user_session_path, class: style_for_link(for_catalog) do
      tag.i(' Войти', class: 'fas fas fa-sign-in-alt', aria_hidden: true)
    end
  end

  def style_for_link(for_catalog)
    for_catalog ? 'thumb-hover-link thumb-icon' : 'btn btn-default pull-right general-position'
  end

  def add_text(text, for_catalog)
    for_catalog ? '' : text
  end
end
