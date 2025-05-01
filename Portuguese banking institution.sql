/* # bank client data:
   1 - age (numeric)
   2 - job : type of job (categorical: "admin.","unknown","unemployed","management","housemaid","entrepreneur","student",
                                       "blue-collar","self-employed","retired","technician","services") 
   3 - marital : marital status (categorical: "married","divorced","single"; note: "divorced" means divorced or widowed)
   4 - education (categorical: "unknown","secondary","primary","tertiary")
   5 - default: has credit in default? (binary: "yes","no")
   6 - balance: average yearly balance, in euros (numeric) 
   7 - housing: has housing loan? (binary: "yes","no")
   8 - loan: has personal loan? (binary: "yes","no")
   
   
   # related with the last contact of the current campaign:
   9 - contact: contact communication type (categorical: "unknown","telephone","cellular") 
  10 - day: last contact day of the month (numeric)
  11 - month: last contact month of year (categorical: "jan", "feb", "mar", ..., "nov", "dec")
  12 - duration: last contact duration, in seconds (numeric)
  
  
   # other attributes:
  13 - campaign: number of contacts performed during this campaign and for this client (numeric, includes last contact)
  14 - pdays: number of days that passed by after the client was last contacted from a previous campaign (numeric, -1 means client was not previously contacted)
  15 - previous: number of contacts performed before this campaign and for this client (numeric)
  16 - poutcome: outcome of the previous marketing campaign (categorical: "unknown","other","failure","success")


  Output variable (desired target):
  17 - y - has the client subscribed a term deposit? (binary: "yes","no")
  */
create database bank;
use bank;

create table bank_details(
age int,
job varchar(20),
marital varchar(20),
education varchar(20),
default_yn varchar(5),
balance int,
housing varchar(5),
loan varchar(5),
contact varchar(20),
day_no int,
month_name varchar(10),
duration int,
campaign int,
pdays int,
previous int,
poutcome varchar(20),
y varchar(5));

select * from bank_details limit 5;

-- Understand the Structure
DESCRIBE bank_details;

-- Shape of the data
SELECT COUNT(*) FROM bank_details;

-- Any NULL values?
SELECT
sum(case when age is null then 1 else 0 end) as age_nulls,
sum(case when job is null then 1 else 0 end) as job_nulls,
sum(case when marital is null then 1 else 0 end) as marital_nulls,
sum(case when education is null then 1 else 0 end) as education_nulls,
sum(case when default_yn is null then 1 else 0 end) as default_yn_nulls,
sum(case when balance is null then 1 else 0 end) as balance_nulls,
sum(case when housing is null then 1 else 0 end) as housing_nulls,
sum(case when loan is null then 1 else 0 end) as loan_nulls,
sum(case when contact is null then 1 else 0 end) as contact_nulls,
sum(case when day_no is null then 1 else 0 end) as day_no_nulls,
sum(case when month_name is null then 1 else 0 end) as month_name_nulls,
sum(case when duration is null then 1 else 0 end) as duration_nulls,
sum(case when campaign is null then 1 else 0 end) as campaign_nulls,
sum(case when pdays is null then 1 else 0 end) as pdays_nulls,
sum(case when previous is null then 1 else 0 end) as previous_nulls,
sum(case when poutcome is null then 1 else 0 end) as poutcome_nulls,
sum(case when y is null then 1 else 0 end) as subscribe_nulls

from bank_details;


-- What is the distribution of clients across different age groups? Are there specific age ranges that are more prevalent in our data?
-- Output : Between 26yr - 45yr have more no of clients
select 
case
when age between 18 and 25 then '18-25'
when age between 26 and 35 then '26-35'
when age between 36 and 45 then '36-45'
when age between 46 and 55 then '46-55'
when age > 55 then '55+'
else 'Too Old'
end as age_range, count(*) as no_of_clients
from bank_details
group by age_range
order by age_range;

-- How does the job type of a client relate to their average yearly balance? Are certain professions associated with higher or lower balances?
-- Output : Retired clients(2300+) have more average balance and any other job titles.
select job , avg(balance) as avg_balance 
from bank_details 
group by job 
order by avg_balance desc;

-- What is the breakdown of clients by marital status and education level? Are there common combinations of these attributes?
-- Output : More than 1000+ married clients are in secondary education level than tertiary.
SELECT marital, education, COUNT(*) AS client_count
FROM bank_details
GROUP BY marital, education
ORDER BY marital, education;

-- What are the most common contact communication types used in the last campaign?
-- Output : Cellular been used mostly in last campaign with over 2800+ count.
select contact , count(*) as common_contact
from bank_details
group by contact
order by common_contact;

-- How does the number of contacts in the current campaign relate to the outcome (subscription)? Is there an optimal number of contacts?
-- Output : Most of them arn't subscribed. The ratio is pretty high. for ex: contact = cellular  total = 2896	yes = 416	no = 2480
SELECT contact,COUNT(contact) AS no_of_contacts, 
       COUNT(CASE WHEN y = 'yes' THEN 1 END) AS successful_subscriptions,
       COUNT(CASE WHEN y = 'no' THEN 1 END) AS unsuccessful_subscriptions
FROM bank_details
GROUP BY contact
ORDER BY no_of_contacts;

-- What kind of people are subscribing(y)?
-- Output : People who has credit aren't subscribed.
SELECT
    age,
    job,
    marital,
    education,
    default_yn,
    housing,
    loan,
    COUNT(*) AS total_people_subscribed
FROM bank_details
WHERE y = 'yes'
GROUP BY age, job, marital, education, default_yn, housing, loan
ORDER BY total_people_subscribed DESC;

-- Impact of previous campaign
SELECT 
    poutcome, 
    COUNT(*) AS total_clients, 
    COUNT(CASE WHEN y = 'yes' THEN 1 END) AS subscribed_count 
FROM bank_details 
GROUP BY poutcome 
ORDER BY subscribed_count DESC;
