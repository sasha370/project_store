[![Tests](https://github.com/sasha370/project_store/actions/workflows/ci.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/ci.yml) [![Deploy To Server](https://github.com/sasha370/project_store/actions/workflows/deploy.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/deploy.yml)

# README

### TODO

- Учитывать в счетчике проектов для категории только опубликованные 
- Вывести аватар\имя пользователя в навбаре
- Хранение и скачивание файлов ( выбрать провайдера и настроить)
- добавить теги для Материалы проекта + Админка
- авторотация для SSL сертификата (90 дней)
- Обновлять корзины если товар сменил цену (сделать сумму динамической ??)
- Съехали поля ввода при ЛОгин  и Регистрации
- Add more test for SortingAndFilteringQuery class (categories)
- Общий мониторинг на системц ( nginx, redis, passenger, rails)

> рассылки
> - настроить серверa
>- подтверждение регистрации\восстановление и т.п.a
>- подтверждение заказа
>- Подписка на новинки
- 

### Админка
- проверить права доступа
- ошибка при удалении картинки


### Tests
- Покрыть страницу "Мои заказы" тестами
- Add Pundit 
- FLaky тесты для сортировок и "показать еще" кнопки

> ### яндекс
> - +Callback  ( `app/controllers/callbacks/yandex_money_controller.rb` )
>- настройки общие https://yoomoney.ru/settings?w=other#apiown
>- настройка формы для отправки данных https://yoomoney.ru/docs/payment-buttons/using-api/forms
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


### Setup
```yaml
rails db:create
rails db:migrate
rails db:seed
yarn install
```
