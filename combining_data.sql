-- LI
-- aggregate raw into the new dataset

create table gbs-auditing.gbs_uncreated_invoice.LI_SEA_main as 
(select t1.Cnty, t1.Pol, cust.string_field_0 as Mstr_Cust ,t1.Child_Cust, t1.Voy, t1.ATD, t1.ETD, t1.Bk, t1.Clp_Svc, t1.Fcr, t1.Invoice_Nbr,t2.Sts, t2.Creation_Dt,
  (select
  case when t1.ATD = t1.ETD
  then t1.ATD
  else t1.ETD
  end) as look_up_date,
    format_date('%A',(select
    case when t1.ATD = t1.ETD
    then t1.ATD
    else t1.ETD
    end)) as day_of_week
from `gbs-auditing.gbs_uncreated_invoice.LI_SEA_no_sts_mstr` as t1
left join `gbs-auditing.gbs_uncreated_invoice.LI_SEA_sts_no_mstr` as t2
on t1.Computed = t2.Computed
left join `gbs-auditing.gbs_uncreated_invoice.customer`as cust
on t1.Child_Cust = cust.string_field_1);

-- OI
-- aggregate raw into the new dataset

create table gbs-auditing.gbs_uncreated_invoice.OI_SEA_main as 
(
select t1.Cnty, t1.Pol, t1.Dest, t1.Dest_Cnty , cust.string_field_0 as Mstr_Cust, t1.Child_Cust, t1.Voy, t1.ATD, t1.ETD, t1.Clp, t1.Clp_Svc, t1.OI, t1. Clp_Vol, t1.Clp_Wt, t2.OI_Sts, t2.Clp_Wt as OI_Wt, t2.Tr_To, t2.Trf_Dt, t1. Cntr, t1.Bl, t1.Abl,
(select
  case when t1.ATD = t1.ETD
  then t1.ATD
  else t1.ETD
  end) as look_up_date,
    format_date('%A',(select
    case when t1.ATD = t1.ETD
    then t1.ATD
    else t1.ETD
    end)) as day_of_week, (select case when round(t2.Clp_Wt,1) = t1.Clp_Wt then 1 else 0 end) as Wt_Diff
from `gbs-auditing.gbs_uncreated_invoice.OI_SEA_no_sts_mstr` as t1
left join `gbs-auditing.gbs_uncreated_invoice.OI_SEA_sts_no_mstr` as t2
on t1.Computed = t2.Computed
left join `gbs-auditing.gbs_uncreated_invoice.customer` as cust
on t1.Child_Cust = cust.string_field_1);

--- backup
create table gbs-auditing.gbs_uncreated_invoice.OI_SEA_backup as 
(
select t1.Cnty, t1.Pol, cust.string_field_0 as Mstr_Cust, t1.Child_Cust, t1.Voy, t1.ATD, t1.ETD, t1.Clp, t1.Clp_Svc, t1.OI, t1. Clp_Vol, t1.Clp_Wt, t2.OI_Sts, t2.Clp_Wt as OI_Wt, t2.Tr_To, t2.Trf_Dt, t1. Cntr, t1.Bl, t1.Abl,
(select
  case when t1.ATD = t1.ETD
  then t1.ATD
  else t1.ETD
  end) as look_up_date,
    format_date('%A',(select
    case when t1.ATD = t1.ETD
    then t1.ATD
    else t1.ETD
    end)) as day_of_week, (select case when round(t2.Clp_Wt,1) = t1.Clp_Wt then 1 else 0 end) as Wt_Diff
from `gbs-auditing.gbs_uncreated_invoice.OI_SEA_no_sts_mstr` as t1
left join `gbs-auditing.gbs_uncreated_invoice.OI_SEA_sts_no_mstr` as t2
on t1.Computed = t2.Computed
left join `gbs-auditing.gbs_uncreated_invoice.customer` as cust
on t1.Child_Cust = cust.string_field_1);
