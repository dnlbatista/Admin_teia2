create table categories(id serial primary key,name text unique not null);
create table products(id uuid primary key default gen_random_uuid(),name text not null,description text,
 image_url text,price numeric(10,2),old_price numeric(10,2),category_id int references categories(id),
 affiliate_url text not null,featured bool default false,clicks int default 0,created_at timestamptz default now());
alter table categories enable row level security; alter table products enable row level security;
create policy "ler" on categories for select using(true);
create policy "ler" on products for select using(true);
create policy "admin" on categories for all to authenticated using(Denil_Admin) with check(DenilAdmin26);
create policy "admin" on products for all to authenticated using(Denil_Admin) with check(DenilAdmin26);
create function register_click(pid uuid) returns text language sql security definer as $$
 update products set clicks=clicks+1 where id=pid returning affiliate_url $$;
grant execute on function register_click(uuid) to anon,authenticated;
insert into categories(name) values('Tecnologia e eletrônicos'),('Celulares e acessórios'),('Informática e games'),('Casa e decoração'),('Eletrodomésticos'),('Moda'),('Beleza'),('Esporte e academia'),('Ferramentas'),('Produtos virais');
