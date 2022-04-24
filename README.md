[![Tests](https://github.com/sasha370/project_store/actions/workflows/ci.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/ci.yml) [![Deploy To Server](https://github.com/sasha370/project_store/actions/workflows/deploy.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/deploy.yml)

# README

### TODO
- Админка в Заказах, Пайментаз и т.п. сделать выбор выпадающих польщователей по именам не по ID 
#### seo
- добавить Breadcrumbs  в карточку проекта
- переименовать все на `diy plans`
- Учитывать в счетчике проектов для категории только опубликованные 
- Вывести аватар\имя пользователя в навбаре
- добавить теги для Материалы проекта + Админка
- Общий мониторинг на систем ( nginx, redis, passenger, rails)
- После удаления товара из корзины JS возвращет число без преобразования  number_to_currency
- Отображать сложность звездочками
- Переработать форму отправки на платеж, вынести в контроллер
- Тесты для смены пароля в личном кабинете
- Rspec тесты в параллель для GHA https://shime.sh/til/running-parallel-rails-tests-on-github-actions

### SMTP server
https://app-smtp.sendinblue.com/real-time

> рассылки
>- подтверждение заказа
>- Подписка на новинки

### Backlog

- создать форму ообратной связи для Вопросов клиентов, чтобы была возможность редиректить при отсутвии файла и автозаполнять ее
- Купоны + скидки ( )
- Бейдж ХИТ в карточке товара и в каталоге (настраиваится из админки).   К нему привязаны ТОП по продажам
- Fix mobile navbar
- Добавить статичные старницы "Условия оплаты" и "Пользовательское соглашение" + ссылки в футере
- https://www.toptal.com/ruby-on-rails/top-10-mistakes-that-rails-programmers-make
- React and new design with //  https://mdbootstrap.com/plugins/react/e-commerce-components/

### CI & CD
 - +Realized with Capistrano and GHA. See `.github/workflows/`
 - Добавить стопер на 95% для покрытия тестами в CI
 - Monit  в качестве мониторинга сервера https://github.com/FoRuby/deploy#monit-utility

> ### яндекс
> - +Callback  ( `app/controllers/callbacks/yandex_money_controller.rb` )

### Setup
```yaml
rails db:create
rails db:migrate
rails db:seed
yarn install
```



