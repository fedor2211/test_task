# Требования
- Ruby 3.x
- bundler
- Rails 8
- sqlite 3

# Запуск
Установка необходимых гемов:
```bash
bundle install
```

Развернуть бд:
```bash
bundle exec db:setup
```

Тесты:
```bash
bundle exec rspec
```

# Решение проблемы с опечаткой Skil
## Вариант 1
1. Создать миграцию на переименовывание таблицы и запустить её:
```ruby
  def up
    rename_table :skils, :skills
  end

  def down
    rename_table :skills, :skils
  end
```
2. Исправить опечатки в коде
## Вариант 2
Подойдёт если делать миграцию нежелательно
1. Задать имя таблицы в модели
```ruby
class Skil
  self.table_name = "skils"
end
```
2. Исправить опечатки в коде
```ruby
class Skill
  self.table_name = "skils"
end
```
