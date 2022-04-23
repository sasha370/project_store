[![Tests](https://github.com/sasha370/project_store/actions/workflows/ci.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/ci.yml) [![Deploy To Server](https://github.com/sasha370/project_store/actions/workflows/deploy.yml/badge.svg)](https://github.com/sasha370/project_store/actions/workflows/deploy.yml)

# README

### TODO
- Сменить валидацию для пароля на простой шестизнак
- переименовать все на `diy plans`
- Учитывать в счетчике проектов для категории только опубликованные 
- Вывести аватар\имя пользователя в навбаре
- добавить теги для Материалы проекта + Админка
- Обновлять корзины если товар сменил цену (сделать сумму динамической ??)
- Общий мониторинг на системц ( nginx, redis, passenger, rails)
- После удаления товара из корзины JS возвращет число без преобразования  number_to_currency
- Отображать сложность звездочками
- Убрать Материалы
- Переработать форму отправки на плтеж, вынести в контроллер
- Тесты для смены пароля в личном кабинете

> рассылки
> - настроить серверa
>- подтверждение регистрации\восстановление и т.п.a
>- подтверждение заказа
>- Подписка на новинки
- 

### Админка


Backlog: 
- локализация + Devise
- activeAdmin css brokes links and colors  (https://skryukov.github.io/rails/activeadmin/2020/09/29/an-unofficial-active-admin-guide.html)
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

