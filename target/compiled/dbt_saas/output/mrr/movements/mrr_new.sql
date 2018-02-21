select
  month,
  sum(total)
from
  "dbt_mktg"."invoices_by_customer"
where
  -- Find customers who had their first invoice this month
  asc_row = 1 
group by
  month