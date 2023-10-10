-- aggregate raw into new dataset

create table gbs-auditing.gbs_uncreated_invoice.LI_SEA_main as 
(select t1.Cnty, t1.Pol, cust.string_field_2 as Mstr_Cust ,t1.Child_Cust, t1.Voy, t1.ATD, t1.ETD, t1.Bk, t1.Clp_Svc, t1.Fcr, t1.Invoice_Nbr,t2.Sts, t2.Creation_Dt,
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
