#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DDL_DIR="$ROOT_DIR/ddl"
MIG_DIR="$ROOT_DIR/migrations"

mkdir -p "$MIG_DIR"
rm -f "$MIG_DIR"/*.sql

dirs=()
while IFS= read -r dir; do
  dirs+=("$dir")
done < <(
  for dir_path in "$DDL_DIR"/*; do
    [ -d "$dir_path" ] || continue
    basename "$dir_path"
  done | sort
)

index=1
for dir in "${dirs[@]}"; do
  num=$(printf "%05d" "$index")
  out="$MIG_DIR/${num}_${dir}.sql"

  {
    echo "-- generated file: ${num}_${dir}.sql"
    echo "-- source directory: ddl/${dir}"
    echo
    echo "BEGIN;"
    echo
  } > "$out"

  order_file="$DDL_DIR/$dir/order.txt"
  if [ ! -f "$order_file" ]; then
    echo "Missing order file: $order_file" >&2
    exit 1
  fi

  sql_files=()
  while IFS= read -r line; do
    file=$(echo "$line" | sed -e 's/#.*$//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    [ -n "$file" ] || continue
    sql_files+=("$file")
  done < "$order_file"

  if [ ${#sql_files[@]} -eq 0 ]; then
    echo "No SQL files listed in $order_file" >&2
    exit 1
  fi

  for file in "${sql_files[@]}"; do
    if [ ! -f "$DDL_DIR/$dir/$file" ]; then
      echo "Listed file not found: $DDL_DIR/$dir/$file" >&2
      exit 1
    fi
  done

  for file in "${sql_files[@]}"; do
    {
      echo "-- file: ${file}"
      cat "$DDL_DIR/$dir/$file"
      echo
    } >> "$out"
  done

  {
    echo "COMMIT;"
    echo
  } >> "$out"

  index=$((index + 1))
done

echo "Generated migrations: $(find "$MIG_DIR" -maxdepth 1 -type f -name '*.sql' | wc -l | tr -d ' ')"
