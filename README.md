[![Tests](https://github.com/sasha370/project_store/actions/workflows/ci.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/ci.yml)

# README

### Setup

rails db:create
rails db:migrate
rails db:seed
yarn install

### CI
stage1: 
- Run linters and test via GHA (done) +
- Made it require
stage2: Deploy workflow
- 

### TODO
- Хранение и скачивание файлов ( выбрать провайдера и настроить)

### Админка
- проверить права доступа
- 

### Tests

- Add Pundit 
- Adaptive Title for all product pages

> ### яндекс
>- После колбека об оплате проверять сумму заказа и только потом записывать
>- Добавить дату оплаты и обработки платежа в таблицу Payments
>- настройть коллбек тут https://yoomoney.ru/transfer/myservices/http-notification?_openstat=settings%3Bother%3Bmoney%3Bhttp%3Bset
>- АПИ коллбека https://yoomoney.ru/docs/wallet/using-api/notification-p2p-incoming
>- настройка формы для отправки данных https://yoomoney.ru/docs/payment-buttons/using-api/forms
>- настройки общие https://yoomoney.ru/settings?w=other#apiown
>- сценарий работы формы https://yoomoney.ru/docs/payment-buttons/using-api/flow


Backlog: 
- поправить дату для заказа на странице Мои покупки
- Купоны + скидки ( )
- Fix mobile navbar
- Страница с условиями оплаты ( статика)
- https://www.toptal.com/ruby-on-rails/top-10-mistakes-that-rails-programmers-make
