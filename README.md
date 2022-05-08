[![Tests](https://github.com/sasha370/project_store/actions/workflows/ci.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/ci.yml) [![Deploy To Server](https://github.com/sasha370/project_store/actions/workflows/deploy.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/deploy.yml)

# README

### TODO

- Добавить фавиконы большиз размеров
- Сделать страницу почему стоит покупать у нас
- 
- Любой пользователь может делать заказ
- Убрать страницы сортировки из моиска
- Кеширование страниц товара ! Redis
- check N+1
- Кнопки следующий\предыдущий в карточке товара
- добавить теги для Материалы проекта + Админка
- добавить Breadcrumbs  в карточку проекта
- Учитывать в счетчике проектов для категории только опубликованные 
- Общий мониторинг на систем ( nginx, redis, passenger, rails)
- Аналогичные товары 

- Rspec тесты в параллель для GHA https://shime.sh/til/running-parallel-rails-tests-on-github-actions
- Настроить электронную коммерцию на связь с яндексом  https://yandex.ru/support/metrica/data/e-commerce.html
- Вывести аватар\имя пользователя в навбаре
- Добавить сортровку картинок в карточке товара

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



