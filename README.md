# IA510 MP2 — Normalization Fix-It

## AI use (course policy)

**Allowed:** explain concepts, approaches, starter snippets, SQL suggestions, README help.

**Required:** frequent commits, this `AI_Usage.md` file, and verification (SQL output, screenshots, or runs).

**Not allowed:** submitting work you do not understand, fabricating evidence, or copying another student's repository.

## Grading: pytest vs rubric

- **pytest** in GitHub Actions is a **pass/fail gate** (does it run, are basic contracts met). It is **not** mapped to rubric point rows.
- Your **instructor assigns the 10 points** using the rubric below.

**Org Actions:** If GitHub Actions are disabled on student repositories in this organization, run the same checks locally: `docker compose up -d` then `pytest -q` (see README). The rubric still applies.


## Goal

Decompose a denormalized design into a normalized model and migrate data safely.

## Deliverables

- `before.sql` — messy source (starter provided; align to your brief).
- `after.sql` — normalized DDL/DML.
- `evidence/` — row counts, screenshots, or notes.
- `AI_Usage.md`

## Verify locally

```bash
docker compose up -d
pip install -r requirements-dev.txt
export PGHOST=localhost PGPORT=5432 PGDATABASE=ia510 PGUSER=ia510_user PGPASSWORD=ia510_pass
pytest -q
docker compose down -v
```

Canonical dataset files live in `db/init/`; keep them unchanged unless the instructor runs a coordinated update across all templates.

## Rubric (10 points)

| Criteria | Excellent | Good | Satisfactory | Needs Improvement | Pts |
| --- | --- | --- | --- | --- | --- |
| Normalization outcome | Correct 3NF-style decomposition; no redundancy | Mostly normalized; minor dependency issues | Partial; redundancy remains | Not normalized | 5 |
| Migration correctness | Data migrated; counts/keys verified | Mostly correct; minor mismatches | Some loss/duplication | Fails or not shown | 3 |
| Explanation + AI log | Explains fixes; AI_Usage shows reasoning | Explains most; ok log | Limited | Missing/unclear | 2 |

