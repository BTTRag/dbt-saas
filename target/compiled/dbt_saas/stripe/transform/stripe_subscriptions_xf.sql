with 

subscriptions as (
 select * from "dbt_mktg"."stripe_subscriptions"
),

plans as (
 select * from "dbt_mktg"."stripe_plans"
)

select 
  subscriptions.*,
  plans.amount/100   as plan_total
from 
  subscriptions
join
  plans
on
  subscriptions.plan_id = plans.id