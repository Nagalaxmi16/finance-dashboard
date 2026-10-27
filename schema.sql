-- Run this in Supabase: Dashboard -> SQL Editor -> New query -> paste -> Run

create table if not exists transactions (
  id               uuid primary key default gen_random_uuid(),
  user_id          uuid,                       -- filled in on Day 3 when we add login
  txn_date         date not null,
  description      text not null,
  amount           numeric(12,2) not null,     -- negative = money out, positive = money in
  category         text not null default 'Uncategorised',
  category_source  text not null default 'none'
                   check (category_source in ('none', 'keyword', 'ai', 'manual')),
  created_at       timestamptz not null default now()
);

-- Makes date-range and per-user queries fast
create index if not exists idx_transactions_user_date
  on transactions (user_id, txn_date);

-- Quick check after running: this should return 0 rows, with no error
select * from transactions;
