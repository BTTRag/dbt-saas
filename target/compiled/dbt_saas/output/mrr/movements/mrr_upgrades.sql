with

upgrades as (
  select 
    invoices.month                                                as month,
    invoices.asc_row                                              as asc_row,
    invoices.total                                                as current_month_total,
    coalesce(invoices_offset_one_month.total,0)                   as last_month_total,
    invoices.total - coalesce(invoices_offset_one_month.total,0)  as change
  from 
    "dbt_mktg"."invoices_by_customer" invoices
  left outer join 
    "dbt_mktg"."invoices_by_customer" invoices_offset_one_month
  on 
    add_months(invoices.month, -1) = invoices_offset_one_month.month
  and 
    invoices.customer_id = invoices_offset_one_month.customer_id
)

select
  month         as month,
  sum(change)   as revenue
from
  upgrades
where
  -- Only include customers whose current month total is more than last month (upgrades!)
  abs(upgrades.current_month_total) > 
  upgrades.last_month_total
and 
  -- Exclude customers who didn't move plans this month
  upgrades.change <> 0 and upgrades.change is not null
and
  -- Exclude customer's first invoices, as these are actually "new" customers, not upgrades
  upgrades.asc_row <> 1
group by
  upgrades.month