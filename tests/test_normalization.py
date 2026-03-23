import pathlib


def _exec_script(conn, path: pathlib.Path) -> None:
    text = path.read_text(encoding="utf-8")
    with conn.cursor() as cur:
        for raw in text.split(";"):
            lines = [
                ln
                for ln in raw.splitlines()
                if ln.strip() and not ln.strip().startswith("--")
            ]
            stmt = "
".join(lines).strip()
            if stmt:
                cur.execute(stmt)


def test_after_sql_runs(db_conn):
    b = pathlib.Path(__file__).resolve().parents[1] / "before.sql"
    a = pathlib.Path(__file__).resolve().parents[1] / "after.sql"
    _exec_script(db_conn, b)
    _exec_script(db_conn, a)


def test_seed_customers_intact(db_conn):
    with db_conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM customers")
        (n,) = cur.fetchone()
    assert n == 2


def test_seed_orders_line_present(db_conn):
    with db_conn.cursor() as cur:
        cur.execute("SELECT COUNT(*) FROM order_lines")
        (n,) = cur.fetchone()
    assert n >= 1
