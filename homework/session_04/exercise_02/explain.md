# Giải thích cơ chế Healthcheck và Volume – StoreX

## 1. Vấn đề của depends_on mặc định
`depends_on` dạng danh sách chỉ đảm bảo thứ tự *khởi chạy container*,
không đảm bảo service bên trong đã sẵn sàng. PostgreSQL cần vài giây để
khởi tạo, nên Backend kết nối quá sớm sẽ bị lỗi "Connection refused".

## 2. Healthcheck
Docker định kỳ chạy một lệnh bên trong container để kiểm tra "sức khoẻ":
- Lệnh trả về exit code 0 → healthy
- Exit code khác 0 → thất bại; sau `retries` lần liên tiếp → unhealthy
- Trạng thái chuyển dần: starting → healthy / unhealthy

| Service  | Lệnh kiểm tra                          | Ý nghĩa                                   |
|----------|----------------------------------------|-------------------------------------------|
| postgres | `pg_isready -U admin -d storex_db`     | Kiểm tra Postgres đã nhận kết nối chưa    |
| redis    | `redis-cli ping`                       | Redis trả về PONG nghĩa là đã sẵn sàng    |

Tham số:
- `interval: 5s` – chạy kiểm tra mỗi 5 giây
- `timeout` – thời gian tối đa cho một lần kiểm tra
- `retries: 10` – số lần thất bại liên tiếp trước khi đánh dấu unhealthy
- `start_period: 10s` – thời gian ân hạn lúc khởi động, lỗi trong giai đoạn
  này không tính vào retries

## 3. depends_on với condition: service_healthy
Backend chỉ được khởi chạy khi cả postgres và redis đều ở trạng thái
`healthy`, nhờ đó không còn crash do khởi động sớm.

## 4. Volume
Named volume `postgres_data` được mount vào `/var/lib/postgresql/data`.
Volume do Docker quản lý độc lập với vòng đời container, nên
`docker compose down` xoá container nhưng không xoá volume, và dữ liệu
được giữ lại.
Lưu ý: `docker compose down -v` SẼ xoá volume.
