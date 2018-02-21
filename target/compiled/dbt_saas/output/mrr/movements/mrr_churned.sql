select
  month,
  sum(total)
from
  "dbt_mktg"."invoices_by_customer"
where
  -- Find customers who had their first invoice this month
  desc_row = 1 
group by
  month