[![Tests](https://github.com/sasha370/project_store/actions/workflows/ci.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/ci.yml) [![Deploy To Server](https://github.com/sasha370/project_store/actions/workflows/deploy.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/deploy.yml)

# README

### TODO
- Снипет для сайта + ЫУЩ для яндекса  [](https://webmaster.yandex.ru/site/https:diy-plans.ru:443/serp-snippets/serp-snippets/?utm_source=webmaster.yandex.ru?utm_medium=quality_recommendation)
- [](https://yandex.ru/support/webmaster/search-results/quick-links.html?utm_source=yandex.webmaster&utm_medium=landing&utm_campaign=site_in_search&utm_content=link_14)

- Кнопки следующий\предыдущий в карточке товара
- добавить теги для Материалы проекта + Админка
- добавить Breadcrumbs  в карточку проекта
- Учитывать в счетчике проектов для категории только опубликованные 
- Общий мониторинг на систем ( nginx, redis, passenger, rails)

- Тесты для смены пароля в личном кабинете
- Rspec тесты в параллель для GHA https://shime.sh/til/running-parallel-rails-tests-on-github-actions
- Настроить электронную коммерцию на связь с яндексом  https://yandex.ru/support/metrica/data/e-commerce.html
- Вывести аватар\имя пользователя в навбаре

### SMTP server
https://app-smtp.sendinblue.com/real-time

> рассылки
>- Подписка на новинки + Рассылка новостей

### Backlog

- Купоны + скидки ( )
- Бейдж ХИТ в карточке товара и в каталоге (настраиваится из админки). К нему привязаны ТОП по продажам
- Fix mobile navbar
- React and new design with //  https://mdbootstrap.com/plugins/react/e-commerce-components/

### CI & CD
 - +Realized with Capistrano and GHA. See `.github/workflows/`
 - Добавить стопер на 95% для покрытия тестами в CI
 - Monit  в качестве мониторинга сервера https://github.com/FoRuby/deploy#monit-utility

> ### яндекс
> - +Callback  ( `app/controllers/callbacks/yandex_money_controller.rb` )



