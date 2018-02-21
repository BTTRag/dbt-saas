
  
    
  

  
    
  

  create view "dbt_mktg"."invoices_by_customer__dbt_tmp" as (
    with 

invoices_by_customer as (
  select
    customer_id,
    date_trunc('month',date) as month,
    sum(total) as total
  from
    "dbt_mktg"."invoices"
  group by
    customer_id,
    date_trunc('month',date)
)

select 
  *,
  row_number() over (partition by customer_id order by month asc)   as asc_row,
  row_number() over (partition by customer_id order by month desc)  as desc_row 
from 
  invoices_by_customer
  ) ;