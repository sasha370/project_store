# frozen_string_literal: true

class ProjectDecorator < ApplicationDecorator
  def images_for_gallery
    gallery = images.order(position: :asc).map do |image|
      original = rails_blob_path(image, only_path: true)
      thumbnail = rails_representation_url(image.variant(:thumb), only_path: true)
      { original: original, thumbnail: thumbnail }
    end
    return [{ original: Project::PLACEHOLDER_IMAGE, thumbnail: Project::PLACEHOLDER_IMAGE }] if gallery.empty?

    gallery
  end

  def cart_buttons
    return go_to_cart_button(for_catalog: false) if already_in_cart

    return download_button(for_catalog: false) if already_bought

    add_to_cart_button(for_catalog: false)
  end

  def cart_buttons_catalog
    return download_button if already_bought

    go_to_cart_button if already_in_cart
  end

  def archive_link
    Rails.application.routes.url_helpers.rails_blob_url(
      archive.blob,
      disposition: 'attachment',
      only_path: true,
      target: '_blank'
    )
  end

  # rubocop:disable Metrics/MethodLength
  def download_button(for_catalog: true)
    if archive.attached?
      link_to archive_link, class: style_for_link(for_catalog), id: "download_project_#{id}" do
        tag.i(for_catalog ? '' : t('cart_buttons.download'), class: 'fa fa-download', aria_hidden: true)
      end
    else
      link_to new_feedback_path, class: style_for_link(for_catalog), id: "file_not_found_#{id}" do
        tag.i(for_catalog ? '' : t('cart_buttons.not_found'),
              class: 'fa fa-download',
              aria_hidden: true,
              title: t('cart_buttons.not_found_description'))
      end
    end
  end

  # rubocop:enable Metrics/MethodLength

  def difficult_icons
    html = []
    (Project::MAX_DIFFICULTY - difficulty).times do
      html << tag.i(class: 'fas fa-hammer disable')
    end
    difficulty.times do
      html << tag.i(class: 'fas fa-hammer')
    end
    safe_join(html)
  end

  private

  def already_bought
    current_user.orders.paid.map(&:project_ids).flatten.include?(id) if current_user
  end

  def already_in_cart
    current_or_guest_user.cart.project_ids.include?(id)
  end

  def add_to_cart_button(for_catalog: true)
    link_to add_to_cart_path(self), class: style_for_link(for_catalog), id: "add_to_cart_#{id}", remote: true do
      tag.i(t('cart_buttons.in_cart'), class: 'fa fa-shopping-cart', aria_hidden: true)
    end
  end

  def go_to_cart_button(for_catalog: true)
    link_to cart_path, class: style_for_link(for_catalog) do
      tag.i(add_text(t('cart_buttons.pay'), for_catalog), class: 'fas fa-coins', aria_hidden: true)
    end
  end

  def style_for_link(for_catalog)
    for_catalog ? 'thumb-hover-link thumb-icon' : 'btn btn-default pull-right general-position'
  end

  def add_text(text, for_catalog)
    for_catalog ? '' : text
  end
end
