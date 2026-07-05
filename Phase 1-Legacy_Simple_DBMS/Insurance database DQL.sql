set search_path to insurance;

-- 1. No. of customers and agents present in a particular city

select c.city, count(distinct c.Customer_id) as num_of_customers, count(distinct a.Agent_id) as num_of_agents
from customer c 
left join agent a
on c.city=a.city
group by c.city
order by num_of_customers desc, num_of_agents desc;


-- 2. List of top 5 performing agents

select pl.Agent_id, concat(a.First_name,' ',a.Last_name) as Name ,count(distinct pl.Policy_no) as num_of_policy, sum(p.amount) as revenue_generated_over_5_years 
from payment p, customer_policy cp, policy pl, agent a
where pl.Policy_no=cp.Policy_no and a.Agent_id=pl.Agent_id and
cp.Customer_id=p.Customer_id and p.billing_id not in (
select Billing_id from claim)
group by pl.Agent_id, a.First_name, a.Last_name
order by revenue_generated_over_5_years desc
limit 5;

-- 3. List of customers who took multiple policies

select cp.customer_id,concat(c.First_name,' ',c.Last_name) as Name, count(cp.customer_id) as num_of_policy
from customer_policy cp, customer c
where c.Customer_id=cp.Customer_id
group by cp.customer_id, c.First_name, c.Last_name
having count(cp.customer_id) >1;


-- 4. Annual change in number of health insurances taken

select extract(year from p.start_date)::int as policy_year, count(p.Policy_no) as Num_of_policy
from policy p, health h
where p.Policy_no=h.Policy_no 
group by policy_year
order by policy_year;


-- 5. Year-wise revenue analysis

with yoy as (
select pa.payment_date as payment_year, sum(pa.amount) as revenue
from  payment pa where
Billing_id not in
(select Billing_id from claim)
group by payment_year
order by revenue desc)

SELECT payment_year, revenue,
revenue - LAG(revenue) OVER ( ORDER BY payment_year ) AS yoy_revenue_difference
FROM yoy;

select * from payment where Customer_id=204;


-- 6. Categorization of insurances according to their premium amount and count of customers in each particular category

select health_plan,count(Policy_no) as num_of_policy, sum(premium) as revenue_by_plan
from 
( select 
case when premium>= 1000 and premium<2000 then 'basic plan'
when premium>=2000 and premium<3000 then 'silver plan'
when premium>=3000 and premium<4500 then 'gold plan'
when premium>=4500 then 'platinum plan'
end as health_plan,p.policy_no,p.premium 
from policy p, health h 
where p.Policy_no=h.Policy_no)d
group by health_plan
order by revenue_by_plan desc;

select car_plan,count(Policy_no) as num_of_policy, sum(premium) as premium
from 
( select 
case when premium>= 1000 and premium<1500 then 'basic plan'
when premium>1500 and premium<=2000 then 'silver plan'
when premium>2000 and premium<=3000 then 'gold plan'
when premium>3000 then 'platinum plan'
end as car_plan,p.policy_no,p.premium 
from policy p, car c 
where p.Policy_no=c.Policy_no)d
group by car_plan
order by premium desc;

select home_plan,count(Policy_no) as num_of_policy, sum(premium) as premium
from 
( select 
case when premium>= 4000 and premium<5000 then 'basic plan'
when premium>=5000 and premium<9000 then 'silver plan'
when premium>=9000 and premium<12000 then 'gold plan'
when premium>=12000 then 'platinum plan'
end as home_plan,p.policy_no,p.premium 
from policy p, home ho 
where p.Policy_no=ho.Policy_no)d
group by home_plan
order by premium desc;

-- 7. Which age group of customers showed more interest to take insurance?

select age_group,count(Policy_no) as num_of_policy
from 
( select 
case when extract(year from age(current_date, c.DoB))>= 18 and extract(year from age(current_date, c.DoB))<31 then '18-30'
when extract(year from age(current_date, c.DoB))>=31 and extract(year from age(current_date, c.DoB))<41 then '31-40'
when extract(year from age(current_date, c.DoB))>=41 and extract(year from age(current_date, c.DoB))<51 then '41-50'
when extract(year from age(current_date, c.DoB))>=51 and extract(year from age(current_date, c.DoB))<61 then '51-60'
when extract(year from age(current_date, c.DoB))>=61 and extract(year from age(current_date, c.DoB))<71 then '61-70'
when extract(year from age(current_date, c.DoB))>=71 and extract(year from age(current_date, c.DoB))<81 then '71-80'
when extract(year from age(current_date, c.DoB))>=81 and extract(year from age(current_date, c.DoB))<91 then '81-90'
end as age_group,p.policy_no,c.DoB
from policy p, customer_policy cp, customer c
where p.Policy_no=cp.Policy_no and cp.Customer_id=c.Customer_id)d
group by age_group
order by num_of_policy desc;
