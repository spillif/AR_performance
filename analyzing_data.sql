----- ranking by cnty, svc
select rnk, Cnty, Clp_Svc, cnt
from(
select Cnty, Clp_Svc, cnt, dense_rank()
over(order by cnt desc) as rnk
from
(select Cnty, Clp_Svc, count(*) as cnt
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
group by Cnty, Clp_Svc)
)
order by rnk;

----- total AOS shipments without LI
select Cnty, Clp_Svc, count(Clp_Svc) as number_of_aos_bk
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
where Clp_Svc = 'AOS' and Sts is null
group by Cnty, Clp_Svc
order by number_of_aos_bk desc;

---- booking with no LI - 253889 records
select *, (select
  case when day_of_week ='Friday' or day_of_week='Saturday' then look_up_date + 3
  when day_of_week='Sunday'  then look_up_date + 2
  else look_up_date +1
  end) as due_date
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
where Sts is null;

----- filter for NV - 142580 records
select *, (select
  case when day_of_week ='Friday' or day_of_week='Saturday' then look_up_date + 3
  when day_of_week='Sunday'  then look_up_date + 2
  else look_up_date +1
  end) as due_date
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
where Sts is null and Cnty = 'NV';

----- filter for NV AOS - Tie in/ NVO with confirmed to create LI - 2169 records
select *, (select
  case when day_of_week ='Friday' or day_of_week='Saturday' then look_up_date + 3
  when day_of_week='Sunday'  then look_up_date + 2
  else look_up_date +1
  end) as due_date
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
where Sts is null and Cnty = 'NV' and Clp_Svc = 'AOS';

----- filter AOS shipment without LI - 11448 records
select *, (select
  case when day_of_week ='Friday' or day_of_week='Saturday' then look_up_date + 3
  when day_of_week='Sunday'  then look_up_date + 2
  else look_up_date +1
  end) as due_date
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
where Sts is null and Clp_Svc = 'AOS';

----- filter CON shipment without LI - 239278 records - do not know if this is the reasonable number or not - advised by Sandra based off the ad-hoc or inquiry from the shipment -----

select *, (select
  case when day_of_week ='Friday' or day_of_week='Saturday' then look_up_date + 3
  when day_of_week='Sunday'  then look_up_date + 2
  else look_up_date +1
  end) as due_date
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
where Sts is null and Clp_Svc = 'CON';

----- filter rest of the shipment without LI - 3151 records
select *, (select
  case when day_of_week ='Friday' or day_of_week='Saturday' then look_up_date + 3
  when day_of_week='Sunday'  then look_up_date + 2
  else look_up_date +1
  end) as due_date
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_main`
where Sts is null and Clp_Svc != 'CON' and Clp_Svc != 'AOS';
