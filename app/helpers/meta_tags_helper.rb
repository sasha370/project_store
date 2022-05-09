# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags # rubocop:disable Metrics/MethodLength:
    {
      site: 'diy-plans.ru',
      title: 'DIY Plans | Все своими руками, чертежи и инструкции',
      reverse: true,
      separator: '|',
      description: 'Готовы сделать будку для собаки, беседку, вольер, курятник или детский домик своими руками?',
      keywords: 'будка для собаки, детский домик, своими руками, чертежи, инструкции, схемы',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: resolve_path_to_image('favicons/favicon.ico'),
          sizes: '16x16' },
        { href: resolve_path_to_image('favicons/favicon-16x16.png'),
          sizes: '16x16', type: 'image/png' },
        { href: resolve_path_to_image('favicons/favicon-32x32.png'),
          sizes: '32x32', type: 'image/png' },
        { href: resolve_path_to_image('favicons/favicon-120x120.png'),
          sizes: '120x120', type: 'image/png' },

        { href: resolve_path_to_image('favicons/apple-touch-icon.png'),
          rel: 'apple-touch-icon',
          sizes: '180x180',
          type: 'image/png' },
        { href: resolve_path_to_image('favicons/android-chrome-192x192.png'),
          sizes: '190x190',
          type: 'image/png' }
      ],
      og: {
        site_name: 'diy-plans.ru',
        title: 'DIY plans',
        description: 'Готовы сделать будку для собаки или игровой домик для детей своими руками, тогда мы Вам поможем!',
        type: 'website',
        url: request.original_url,
        image: resolve_path_to_image('logo.png')
      }
    }
  end
end
