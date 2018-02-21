select
  month,
  sum(total) * -1 as revenue
from
  {{ref('invoices_by_customer')}}
where
  -- Find customers who had their first invoice this month
  desc_row = 1 
group by
  month