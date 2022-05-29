[![Tests](https://github.com/sasha370/project_store/actions/workflows/ci.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/ci.yml) [![Deploy To Server](https://github.com/sasha370/project_store/actions/workflows/deploy.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/deploy.yml)

## https://diy-plans.ru

Простой магазин по продаже чертежей и инструкций для изготовления уличных конструкций своими руками.

### Тех.описание
1) Проект на RoR 6.1 + Ruby 2.7.2 + Webpack
2) Автотесты и линтеры реализованы на GithubAction, при успехе -> автодеплой
3) Деплой на отдельный сервер при помощи GithubAction + Capistrano
4) Оплата через Яндекс кошелек + webhook (донатная схема)
5) Хранилище на AWS S3
6) Галерея реализована на React (просто как попатка его попробовать)
7) ActiveAdmin + Devise + GuestUser
8) Небольшие доработки по SEO (теги, meta, автоотчет по товарам для Yandex)


### TODO
- Сделать страницу "почему стоит покупать у нас"
- Кеширование страниц товара + Redis
- check N+1
- добавить Breadcrumbs  в карточку проекта
- Учитывать в счетчике проектов для категории только опубликованные 

### SMTP server
https://app-smtp.sendinblue.com/real-time

### рассылки
- Подписка на новинки + Рассылка новостей

### Backlog
- Кнопки следующий\предыдущий в карточке товара
- добавить теги для Материалы проекта + Админка
- Monit  в качестве мониторинга сервера https://github.com/FoRuby/deploy#monit-utility
- Аналогичные товары
- Купоны + скидки ( )
- Бейдж ХИТ в карточке товара и в каталоге (настраиваится из админки). К нему привязаны ТОП по продажам
- Fix mobile navbar
- React and new design with //  https://mdbootstrap.com/plugins/react/e-commerce-components/
- Rspec тесты в параллель для GHA https://shime.sh/til/running-parallel-rails-tests-on-github-actions


### CI & CD
 - Добавить стопер на 95% для покрытия тестами в CI
