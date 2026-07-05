create schema if not exists insurance;
set search_path to insurance;

create table insurance.Company(Branch_id int not null primary key, 
No_of_employee int not null,
City varchar(500), 
Zipcode int);

create table insurance.Agent(Agent_id int not null primary key, 
First_name varchar(500) not null,
Last_name varchar(500) not null,
Phone_num int,
Email varchar(500), 
City varchar(500), 
Zipcode int,
Branch_id int,
FOREIGN KEY(Branch_id) REFERENCES Company(Branch_id) on delete cascade on update cascade);

create table insurance.Customer(Customer_id int not null primary key, 
DoB date,
First_name varchar(500) not null,
Last_name varchar(500) not null,
Phone_num int,
Email varchar(500), 
City varchar(500), 
Zipcode int,
Agent_id int,
FOREIGN KEY(Agent_id) REFERENCES Agent(Agent_id) on delete cascade on update cascade);

create table insurance.Policy(Policy_no int not null primary key, 
Start_date date not null, -- yyyy-mm-dd
End_date date not null ,
Premium int, 
Coverage int, 
Branch_id int,
FOREIGN KEY(Branch_id) REFERENCES Company(Branch_id) on delete cascade on update cascade,
Agent_id int,
FOREIGN KEY(Agent_id) REFERENCES Agent(Agent_id) on delete cascade on update cascade);

create table insurance.Customer_Policy(Customer_id int,
Policy_no int,
primary key (Customer_id, Policy_no),
FOREIGN KEY(Policy_no) REFERENCES Policy(Policy_no) on delete cascade on update cascade,
FOREIGN KEY(Customer_id) REFERENCES Customer(Customer_id) on delete cascade on update cascade);

create table insurance.Payment(Billing_id int not null primary key, 
Bank_account_no int not null,
Payment_date int, 
Amount int,
Customer_id int,
FOREIGN KEY(Customer_id) REFERENCES Customer(Customer_id) on delete cascade on update cascade);

create table insurance.Claim(Claim_id int not null primary key, 
Amount_issued int not null,
Date_issued date, 
Billing_id int,
FOREIGN KEY(Billing_id) REFERENCES Payment(Billing_id) on delete cascade on update cascade);

create table insurance.Policy_Claim(Claim_id int,
Policy_no int,
primary key (Claim_id, Policy_no),
FOREIGN KEY(Policy_no) REFERENCES Policy(Policy_no) on delete cascade on update cascade,
FOREIGN KEY(Claim_id) REFERENCES Claim(Claim_id) on delete cascade on update cascade);

create table insurance.Health(Health_id int not null primary key, 
Medical_history varchar(5000),
Associated_hospital varchar(5000) , 
Treatment_not_insured varchar(5000), 
Policy_no int,
FOREIGN KEY(Policy_no) REFERENCES Policy(Policy_no) on delete cascade on update cascade);

create table insurance.Car(Car_Num int not null primary key, 
Model varchar(1000),
Registration_Year int , 
Policy_no int,
FOREIGN KEY(Policy_no) REFERENCES Policy(Policy_no) on delete cascade on update cascade);

create table insurance.Home(Home_no int not null primary key, 
Home_type varchar(500),
City varchar(500), 
Zipcode int,
Year_built int,
Area int,
Policy_no int,
FOREIGN KEY(Policy_no) REFERENCES Policy(Policy_no) on delete cascade on update cascade);

alter table insurance.agent
alter column Phone_num type varchar(50) using Phone_num::varchar(50);

alter table insurance.customer
alter column Phone_num type varchar(50) using Phone_num::varchar(50);

create or replace function payment_check_fn()
returns trigger
language plpgsql
as $$
declare
  prem int;
begin
  select distinct p.premium
  into prem
  from policy p
  join customer_policy cp on cp.policy_no = p.policy_no
  where new.customer_id = cp.customer_id
  limit 1;

  if new.amount < prem then
    raise exception 'Amount you are trying to enter is less than your Premium';
  elsif new.amount > prem then
    raise exception 'Amount you are trying to enter is more than your Premium';
  end if;

  return new;
end;
$$;

drop trigger if exists payment_check on payment;
create trigger payment_check
before insert on payment
for each row
execute function payment_check_fn();
