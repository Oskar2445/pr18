-- Практика 18. Згенеровані стовпці у SQLite (варіант 1: books)
-- База взята з практики 17. Додаємо тільки GENERATED VIRTUAL колонки.
ALTER TABLE books ADD COLUMN copies_two_branches INTEGER
    GENERATED ALWAYS AS (copies_count * 2) VIRTUAL;

ALTER TABLE books ADD COLUMN is_technical_book INTEGER
    GENERATED ALWAYS AS (genre IN ('Технології', 'Програмування')) VIRTUAL;

-- Завдання 1: базова колонка і числове похідне значення
SELECT id, title, copies_count, copies_two_branches FROM books ORDER BY id;

-- Завдання 2: прапорець для технічної літератури (1/0)
SELECT id, title, genre, is_technical_book FROM books ORDER BY id;

-- Завдання 3: навмисна помилка (SQLite: cannot UPDATE generated column "copies_two_branches")
UPDATE books SET copies_two_branches = 1 WHERE id = 1;

-- Завдання 4: SELECT до зміни базового значення
SELECT id, title, copies_count, copies_two_branches FROM books WHERE id = 1;
-- Зміна базової колонки: копії для книги id=1 тепер 6
UPDATE books SET copies_count = 6 WHERE id = 1;
-- SELECT після зміни: похідне значення перераховано автоматично
SELECT id, title, copies_count, copies_two_branches FROM books WHERE id = 1;

-- Завдання 5: WHERE за generated column
SELECT id, title, copies_count, copies_two_branches FROM books
WHERE copies_two_branches >= 6 ORDER BY id;
