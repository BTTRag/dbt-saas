select
  *,
  plan__interval as plan_interval,
  plan__id as plan_id
from
  {{ var('invoice_line_items_table') }}