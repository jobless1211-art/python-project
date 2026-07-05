# Итоговый проект: API библиотеки фильмов на FastAPI

Проект реалиует backend «Фильмотеки»: регистрацию и вход пользователей, JWT-авторизацию, каталог фильмов,жанров и режиссёров, профиль пользователя, и збранное и тесты.



## Быстрый запуск
ДЛя быстрого запуска необхдимо открыть открыть start_api.bat или start_api.cmd

```bash
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env       # если .env ещё нет
uvicorn app.main:app --reload
```

Swagger UI:

```text
http://127.0.0.1:8000/docs
```

## Заполнение демонстрационными данными

```bash
python seed_data.py
```

## Запуск тестов

```bash
pytest
```

## Основные эндпоинты

### Auth

- `POST /auth/register` — регистрация, возвращает `access_token` и `refresh_token`.
- `POST /auth/login` — вход, возвращает пару токенов.
- `PUT /auth/refresh` — обновление токенов по refresh token.

### Users

- `GET /users/me` — профиль текущего пользователя.
- `PATCH /users/me` — изменение имени, фамилии, любимого жанра.
- `PUT /users/me/password` — смена пароля.
- `GET /users/me/favorites` — список избранных фильмов.

### Movies

- `GET /movies` — список фильмов.
- `GET /movies?page=1&status=new` — новинки с пагинацией по 12 фильмов.
- `GET /movies?query=matrix&genre_id=1&director_id=2&year=1999` — дополнительные фильтры.
- `GET /movies/{movie_id}` — подробная информация о фильме.

### Genres / Directors

- `GET /genres`, `GET /genres/{genre_id}`.
- `GET /directors`, `GET /directors/{director_id}`.

### Favorites

- `POST /favorites/movies/{movie_id}` — добавить фильм в избранное.
- `DELETE /favorites/movies/{movie_id}` — удалить фильм из избранного.

## Примеры запросов

Регистрация:

```http
POST /auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123",
  "first_name": "Иван",
  "last_name": "Иванов",
  "favorite_genre_id": 1
}
```

Вход:

```http
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

Просмотр профиля:

```http
GET /users/me
Authorization: Bearer <access_token>
```
