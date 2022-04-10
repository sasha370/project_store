[![Tests](https://github.com/sasha370/project_store/actions/workflows/ci.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/ci.yml) [![Deploy To Server](https://github.com/sasha370/project_store/actions/workflows/deploy.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/deploy.yml)

# README

### Setup
```yaml
rails db:create
rails db:migrate
rails db:seed
yarn install
```

### TODO
- Добавить автогенерацию для Артикла для проекта
- Учитывать в счетчике проектов для категории только опубликованные 
- Вывести аватар\имя пользователя в навбаре
- Хранение и скачивание файлов ( выбрать провайдера и настроить)

> рассылки
> - настроить сервер
>- подтверждение регистрации\восстановление и т.п.
>- подтверждение заказа
>- Подписка на новинки
- 

### Админка
- проверить права доступа
- Нельзя загрузить сразу пачку картинок
- ошибка при удалении картинки
- Улучшить интерфейс и рассположение кнопок (Слишком мелкий интрефейс)
- Некоректная привязка автора к проекту ( не дает создать товар)


### Tests
- Покрыть страницу "Мои заказы" тестами
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
- activeAdmin css brokes links and colors  (https://skryukov.github.io/rails/activeadmin/2020/09/29/an-unofficial-active-admin-guide.html)

- Купоны + скидки ( )
- Бейдж ХИТ в карточке товара и в каталоге (настраиваится из админки)
- Fix mobile navbar
- Страница с условиями оплаты ( статика)
- https://www.toptal.com/ruby-on-rails/top-10-mistakes-that-rails-programmers-make


### CI & CD
 - +Realized with Capistrano and GHA. See `.github/workflows/`
 - Добавить стопер на 95% для покрытия тестами в CI

