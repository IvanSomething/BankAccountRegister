# Тестовое задание "Регистр счетов в банке"

## Описание приложения
Создать систему учета банковских счетов пользователей.

### Функциональность
* Создание пользователя с указанием тегов.
	Для создания пользователя нужно заполнить поля: ФИО,идентификационный номер, теги.
	Ограничения: нельзя создать двух пользователей с одинаковым идентификационным номером.
	Сделать максимально просто. Пример: отдельный эндпоинт, rake-task или часть "меню" cli.
	
* Открытие счета для пользователя по идентификационному номеру пользователя.
	Для открытия счета нужно заполнить поля: валюта (по стандарту ISO4217), идентификационный номер пользователя. После открытия счета система указывает уникальный номер нового счета.
	Ограничения: пользователь не может создать два счета с одной и той жевалютой, сумма должна быть неотрицательной.
* Пополнение счета по идентификационному номеру пользователя и валюте на определенную сумму. Если у получателя нет счета в данной валюте, необходимо создать и провести операцию.
* Перевод между счетами по идентификационному номеру пользователя-отправителя, валюте и идентификационному номеру получателя. Если уполучателя нет счета в данной валюте, необходимо создать и провести операцию.
* Отчет "О сумме пополнений за период времени по-валютно" свозможностью фильтрации по пользователям.
* Отчет "Средняя, максимальная и минимальная сумма переводов по тегам пользователей за период времени" с возможностью фильтрации по тегам.
* Отчет "Сумма всех счетов на текущий момент времени повалютно" с фильтрацией по тегам пользователей.

## Требования

* Реализовать проект на языке ruby.
* Для реализации можно использовать:
	* любой веб-фреймворк в режиме json api (пример: rails, sinatra, hanami-api, roda);
	* или консольное приложение без веб-интерфеса.
* Для работы с проектом, зависимостями и gems использовать bundler.
* Написать тесты с использованием rspec на функционал "Перевод между счетами" и отчет "о сумме пополнений за период времени по-валютно".
* Можно добавлять ограничения на функциональность по своему усмотрению, но они должны быть логичны и причины описаны в Readme-файле.
* Разрешается добавлять дополнительные сущности, индексы, связи,классы, модули и ограничения  и т.п. по мере необходимости. В Readme-файле указать причины добавления.
* Предоставить выполненное задание в виде ссылки на открытый репозиторий на github. Все замечания, идеи для проверяющего просьба поместить в Readme-файл.

### Дополнительно будет учитываться

* дополнительное покрытие тестами
* документация о том, как разворачивать приложение и работать с приложением 
* дополнительный функционал, что все отчеты могут быть выведены на экран или в csv файл на диске
* docker-контейнер или деплой проекта


## Работа с приложением

Для работы с приложением используется инструмент rake:
 * на локальном сервере: http://localhost:3000

### Создание нового пользователя

    rake "user:create[John,Doe,4th,18,Belarus]"

Новый пользователь успешно создан: 

    SUCCESS: {"id"=>3, "name"=>"John", "surname"=>"Doe", "patronymic_name"=>"4th", "identification_number"=>"18", "created_at"=>"2021-08-15T10:10:38.044Z", "updated_at"=>"2021-08-15T10:10:38.044Z"}

Пользователь с таким идентификационным номером уже существует:

    FAILURE: {:identification_number=>["has already been taken"]}

### Открытие счета для пользователя

    curl -d '{"account":{"currency":"usd"}, "identification_number":"18"}' -H "Content-Type: application/json" -X POST http://localhost:3000/accounts/

Новый счет успешно создан:

	{"id":2,"currency":"usd","amount":0,"user_id":3,"created_at":"2021-08-28T11:12:05.350Z","updated_at":"2021-08-28T11:12:05.350Z"

Счет с такой валютой уже существует:

	{"currency":["an account with this currency already exists"]}

### Пополнение счета
    
	curl -d '{"account":{"currency":"usd","amount":"4"}}' -H "Content-Type: application/json" -X POST http://localhost:3000/transactions/1/deposit

Счет успешно пополнен:

    {"user_id":3,"amount":8,"id":3,"currency":"usd","created_at":"2021-08-28T15:40:40.054Z","updated_at":"2021-08-29T09:49:47.367Z"}

### Перевод между счетами

    curl -d '{"account":{"currency":"usd","amount":"4"},"sender_identification_number":"1","recipient_identification_number":"2"}' -H "Content-Type: application/json" -X POST http://localhost:3000/transactions/transfer 
    
Средства успешно переведены:

	{"sender_account":{"amount":4,"id":3,"currency":"usd","user_id":3,"created_at":"2021-08-28T15:40:40.054Z","updated_at":"2021-08-29T09:52:06.577Z"},"recipient_account":{"amount":16,"id":4,"currency":"usd","user_id":4,"created_at":"2021-08-28T15:40:51.341Z","updated_at":"2021-08-29T09:52:06.586Z"}}

### Отчет "О сумме пополнений за период времени по-валютно"

	curl -d '{"account":{"user_ids":["1"],"date_from":"2021-01-01", "date_to":"2021-12-01", "report_type":"deposits_report"}}' -H "Content-Type: application/json" -X GET http://localhost:3000/reports

Пример отчета: 

	{"usd":[{"amount":4,"user":"Doe"},{"amount":4,"user":"Doe"},{"amount":4,"user":"Doe"}]}


### Отчет "Средняя, максимальная и минимальная сумма переводов по тегам пользователей за период времени" 
    
	curl -d '{"account":{"user_ids":["1"],"tags":"foo","date_from":"2021-01-01", "date_to":"2021-12-01", "report_type":"measures_report"}}' -H "Content-Type: application/json" -X GET http://localhost:3000/reports

Пример отчета:

	{"Belarus":[{"avg":"3.0","max":4,"min":2}]}

### Отчет "Сумма всех счетов на текущий момент времени повалютно"

    curl -d '{"account":{"user_ids":["1"],"tags":"foo","date_from":"2021-01-01", "date_to":"2021-12-01", "report_type":"total_amount_report"}}' -H "Content-Type: application/json" -X GET http://localhost:3000/reports

Пример отчета:

	{"usd":[{"amount":36}]}