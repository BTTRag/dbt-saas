select
  id                      as id,
  amount_due              as amount_due,
  customer                as customer,
  date                    as date,
  period_end              as period_end,
  forgiven                as forgiven,
  paid                    as paid,
  subscription            as subscription,
  total                   as total,
  starting_balance        as starting_balance
from
  production.vero_stripe_redo.stripe_invoices
where
  -- Remove customer IDs of users who will mess up MRR and other figures (e.g test accounts)
  customer not in ('cus_3Ma5IxIINayMgK')