### Nginx Based RMPT Streaming Server

Сервер для организации стриминга.
Работает в Nginx с плагином [nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module).

## Запуск
1. Запустите сервер RTMP:
```cmd
docker compose up -d
```
2. Запустите ваш Stream:
   * Укажите адрес RTMP-сервера: rtmp://SERVER_HOST:1935/live
   * Укажите ключ потока: STEAM_KEY
3. Проверьте stream: http://SERVER_HOST:8080/stream?key=STREAM_KEY 