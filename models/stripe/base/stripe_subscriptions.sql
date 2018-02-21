select 
  id        as id,
  customer  as customer,
  plan__id  as plan_id,
  ended_at  as ended_at,
  start     as start
from
  {{ var('subscriptions_table') }}