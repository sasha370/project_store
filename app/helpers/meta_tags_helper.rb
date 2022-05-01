# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags # rubocop:disable Metrics/MethodLength:
    {
      site: 'diy-plans.ru',
      title: 'DIY Plans | Все своими руками, чертежи и инструкции',
      reverse: true,
      separator: '|',
      description: 'Готовы сделать будку для собаки или игровой домик для детей своими руками, тогда мы Вам поможем!',
      keywords: 'будка для собаки, детский домик, своими руками, чертежи, инструкции, схемы',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_pack_tag('favicons/favicon.ico'),
          sizes: '16x16 32x32' },
        { href: image_pack_tag('favicons/apple-touch-icon.png'),
          rel: 'apple-touch-icon',
          sizes: '180x180',
          type: 'image/png' }
      ],
      og: {
        site_name: 'diy-plans.ru',
        title: 'DIY plans',
        description: 'Своими руками чертежи, инструкции',
        type: 'website',
        url: request.original_url
        # image: image_pack_tag('login-page.png') # TODO
      }
    }
  end
end
