# 🤖 GitHub Actions CI/CD — Deployment Guide

Цей документ описує, як налаштувати автоматичний деплой проєкту **Koala Platform** на production-сервер через **GitHub Actions**.

---

## ✅ Можливості

- Автоматичний запуск CI при кожному `push` / `pull request` у `main`
- Лінтери, безпекові перевірки, тести, генерація Swagger
- Автоматичний деплой на сервер після успішного тесту

---

## 📂 Структура CI

GitHub Actions файл: 
```.github/workflows/ci.yml```

Цей файл складається з двох `jobs`:

1. `test` — перевірка коду (rubocop, brakeman, rspec, swagger)
2. `deploy` — деплой на сервер по SSH після успішного тесту

---

## 🔐 Secrets у GitHub

Перейдіть у **Settings > Secrets and variables > Actions** вашого репозиторію та додайте:

| Назва              | Значення (приклад)                     |
|--------------------|----------------------------------------|
| `SSH_PRIVATE_KEY`  | Приватний ключ без пароля (OpenSSH формат) |
| `SSH_USER`         | Користувач сервера (наприклад `deploy`) |
| `SSH_HOST`         | IP або hostname сервера                |
| `DOMAIN`           | Наприклад `koala.example.com`          |
| `LETSENCRYPT_EMAIL`| Email для Let's Encrypt                |

> 📌 `SSH_PRIVATE_KEY` — повинен мати доступ до репозиторію на сервері.

---

