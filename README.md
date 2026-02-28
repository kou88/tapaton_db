# tapaton_db

## Directory

```text
tapaton_db/
  ddl/
    001_xxx/
      <table_name>.sql
      order.txt
    002_xxx/
      <table_name>.sql
      order.txt
  migrations/
    00001_001_xxx.sql
    00002_002_xxx.sql
  tools/
    build_migrations.sh
```

## Rules

- 1 directory in `ddl/` = 1 migration file in `migrations/`.
- SQL files are named by table/resource name (for example: `r_item.sql`, `c_item_has_resource.sql`).
- `order.txt` defines the concatenation order inside each `ddl/<dir>/`.
- Commit both `ddl/` and `migrations/`.

## Build

```bash
./tools/build_migrations.sh
```
