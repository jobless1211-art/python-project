from app.crud.director import DirectorCRUD
from app.crud.genre import GenreCRUD
from app.crud.movie import MovieCRUD
from app.database import SessionLocal, create_db_and_tables


def get_or_create_genre(db, name: str):
    genre = GenreCRUD.get_genre_by_name(db, name)
    return genre or GenreCRUD.create_genre(db, name)


def get_or_create_director(db, name: str):
    director = DirectorCRUD.get_director_by_name(db, name)
    return director or DirectorCRUD.create_director(db, name)


def main() -> None:
    create_db_and_tables()
    db = SessionLocal()
    try:
        sci_fi = get_or_create_genre(db, "Фантастика")
        drama = get_or_create_genre(db, "Драма")
        thriller = get_or_create_genre(db, "Триллер")

        nolan = get_or_create_director(db, "Кристофер Нолан")
        wachowski = get_or_create_director(db, "Лана и Лилли Вачовски")
        zemeckis = get_or_create_director(db, "Роберт Земекис")

        if not MovieCRUD.get_movies(db):
            movies = [
                ("Интерстеллар", "Путешествие группы исследователей через червоточину.", "https://example.com/interstellar", 2014, 8.7, sci_fi.id, nolan.id),
                ("Начало", "Вор крадёт секреты через технологию совместных сновидений.", "https://example.com/inception", 2010, 8.8, thriller.id, nolan.id),
                ("Матрица", "Хакер узнаёт, что его мир — симуляция.", "https://example.com/matrix", 1999, 8.7, sci_fi.id, wachowski.id),
                ("Форрест Гамп", "История доброго человека на фоне событий XX века.", "https://example.com/forrest", 1994, 8.8, drama.id, zemeckis.id),
            ]
            for item in movies:
                MovieCRUD.create_movie(db, *item)
        print("Демонстрационные данные добавлены")
    finally:
        db.close()


if __name__ == "__main__":
    main()
