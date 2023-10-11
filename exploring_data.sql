--- checking null values
select
count(*) - count(Cnty) Cnty,
count(*) - count(Pol) Pol,
count(*) - count(Mstr_Cust) Mstr_Cust,
count(*) - count(Child_Cust) Child_Cust,
count(*) - count(Voy) Voy,
count(*) - count(ATD) ATD,
count(*) - count(ETD) ETD,
count(*) - count(Bk) Bk,
count(*) - count(Clp_Svc) Clp_Svc,
count(*) - count(Fcr) Fcr,
count(*) - count(Invoice_Nbr) Invoice_Nbr,
count(*) - count(Sts) Sts,
count(*) - count(Creation_Dt) Creation_Dt,
count(*) - count(look_up_date) look_up_date,
count(*) - count(day_of_week) day_of_week
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`;

--- checking length
select length(Cnty)as length_cnty
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
group by length_cnty;

--- # of bk per cnty
select Cnty, count(*) as number_of_bk
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
group by Cnty;

--- # of bk per svc and cnty
select Cnty, Clp_Svc ,count (Clp_Svc) as number_of_bk
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
group by Cnty, Clp_Svc
order by Cnty;

--- # bk by columns
select Cnty, AOS, CON, ALM, Others
from
(select Cnty, Clp_Svc,
case when (Clp_Svc='AOS') then count(*) end as AOS,
case when (Clp_Svc='CON') then count(*) end as CON,
case when (Clp_Svc='ALM') then count(*) end as ALM,
case when (Clp_Svc != 'AOS' and Clp_Svc != 'CON' and Clp_Svc != 'ALM') then count(*) end as Others
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
group by Cnty, Clp_Svc)
order by Cnty;
