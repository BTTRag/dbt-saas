select
  new_revenue.month,
  new_revenue.revenue         as new_revenue,
  churned_revenue.revenue     as churned_revenue,
  upgrade_revenue.revenue     as upgrade_revenue,
  downgrade_revenue.revenue   as downgrade_revenue
from
  {{ref('mrr_new')}} new_revenue
left outer join
  {{ref('mrr_churned')}} churned_revenue
on
  new_revenue.month = churned_revenue.month
left outer join
  {{ref('mrr_upgrades')}} upgrade_revenue
on
  new_revenue.month = upgrade_revenue.month
left outer join
  {{ref('mrr_downgrades')}} downgrade_revenue
on
  new_revenue.month = downgrade_revenue.month
where
  -- This works in Redshift, not in Postgres
  new_revenue.month < date_trunc('month',dateadd(months,-1,current_date))
order by
  new_revenue.month desc
