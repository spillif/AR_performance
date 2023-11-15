---- final output for all origins

select * from
(
  select * from
  (
  select * from `gbs-auditing.gbs_uncreated.sea_oi`
  where Cnty='ML'
  and Mstr_Cust not in ('TRKMY','PNG','XECCL','XANSEL', 'X2NIEG','RIPP')
  )

union all

  select * from
  (
    select * from `gbs-auditing.gbs_uncreated.sea_oi`
    where Cnty='TH'
    and Mstr_Cust not in ('X2IKTT','X2TCTC')
  )

union all

  select * from
  (
    select * from `gbs-auditing.gbs_uncreated.sea_oi`
    where Cnty='SI'
    and Mstr_Cust not in ('X2SCA','HPC','GPDC','XKWET')
    and Child_Cust != 'GCO'
  )

union all

  select * from
  (
    select * from `gbs-auditing.gbs_uncreated.sea_oi`
    where Cnty='NV' and Mstr_Cust not in ('GAP','DEICH','XGPWH')
    and Child_Cust not in ('CONVRS','OUTDOR')
    and Child_Cust not in (select Child_Cust from `gbs-auditing.gbs_uncreated.sea_oi` where Child_Cust ='SWOOSH' and Clp_Svc = 'ALM')
    and Child_Cust not in (select Child_Cust from `gbs-auditing.gbs_uncreated.sea_oi` where Child_Cust ='IMAGE' and Clp_Svc ='ALM')
    and Child_Cust not in (select Child_Cust from `gbs-auditing.gbs_uncreated.sea_oi` where Child_Cust ='ARMOUR' and Dest_Cnty ='AU')
  )

union all

  select * from
  (
    select * from `gbs-auditing.gbs_uncreated.sea_oi`
    where Cnty='CB'
    and Mstr_Cust != 'DEICH'
    and Child_Cust not in (select Child_Cust from `gbs-auditing.gbs_uncreated.sea_oi` where Child_Cust ='SWOOSH' and Clp_Svc ='ALM')
    and Child_Cust not in (
      select Child_Cust from `gbs-auditing.gbs_uncreated.sea_oi` where Mstr_Cust ='GAP' 
        and (Clp_Svc in ('CON', 'AOS') and Dest_Cnty in ('US', 'CA') or Clp_Svc in ('ALM', 'EAS') and Dest_Cnty in ('JA', 'NE') or Clp_Svc in ('ALM','EAS') 
        and Dest_Port='SHA')
      )
    and Child_Cust not in (select Child_Cust from `gbs-auditing.gbs_uncreated.sea_oi` where Child_Cust ='ARMOUR' and Dest_Cnty='AU')
  )

union all

  select * from
  (
    select * from `gbs-auditing.gbs_uncreated.sea_oi`
    where Cnty= 'BU' and Mstr_Cust != 'DEICH'
  )

union all

  select * from
  (
    select * from `gbs-auditing.gbs_uncreated.sea_oi`
    where Cnty= 'PH' and Mstr_Cust not in ('GAP','XINCS','XSEPH')
  )

union all

  select * from
  (
    select * from `gbs-auditing.gbs_uncreated.sea_oi`
    where Cnty= 'ID' 
    and Mstr_Cust not in ('GAP','XPTBE','XPTYH','XPTZI','XPYEI','PNG','XPTUH')
  )

union all

  select * from
  (
    select * from `gbs-auditing.gbs_uncreated.sea_oi`
    where Cnty in ('AU','NZ') and Mstr_Cust not in ('GPDC','PNG')
  )

)

where OI_Created_ is false and Child_Cust not in ('UAWEN','UAAIR')
order by Cnty, Ld_Port, Mstr_Cust, Voy_Nbr;
