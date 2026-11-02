-- FLR Players table setup
-- Run once in Supabase SQL Editor. This does not expose any service-role key.
create table if not exists public.players (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  team_id uuid references public.teams(id) on delete set null,
  position text,
  shirt_number integer not null default 0 check (shirt_number >= 0),
  avatar_url text,
  goals integer not null default 0 check (goals >= 0),
  assists integer not null default 0 check (assists >= 0),
  yellow_cards integer not null default 0 check (yellow_cards >= 0),
  red_cards integer not null default 0 check (red_cards >= 0),
  clean_sheets integer not null default 0 check (clean_sheets >= 0),
  created_at timestamptz not null default now()
);
alter table public.players enable row level security;
drop policy if exists "Players are public" on public.players;
create policy "Players are public" on public.players
for select to anon, authenticated using (true);
drop policy if exists "Owners can insert players" on public.players;
create policy "Owners can insert players" on public.players
for insert to authenticated
with check (exists (
  select 1 from public.user_roles ur
  where ur.user_id = auth.uid() and ur.role in ('owner','admin')
));
drop policy if exists "Owners can update players" on public.players;
create policy "Owners can update players" on public.players
for update to authenticated
using (exists (
  select 1 from public.user_roles ur
  where ur.user_id = auth.uid() and ur.role in ('owner','admin')
))
with check (exists (
  select 1 from public.user_roles ur
  where ur.user_id = auth.uid() and ur.role in ('owner','admin')
));
drop policy if exists "Owners can delete players" on public.players;
create policy "Owners can delete players" on public.players
for delete to authenticated
using (exists (
  select 1 from public.user_roles ur
  where ur.user_id = auth.uid() and ur.role in ('owner','admin')
));
