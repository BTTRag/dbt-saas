-- Annoyingly, the plan_id is on the line_items of an invoice, not on the invoice itself.
-- This means we need to join, find all related line items, the plans and then divide by 12 
-- to get the right amount_due for annual subscriptions. We can then join this table to the
-- main invoices table to get the right total. This just avoids a whole windowing setup, which
-- Redshift doesn't always love.

with stripe_invoices_with_line_items_year_adjusted as (
  select 
    stripe_invoices.id                                    as id,
    case invoice_line_items.plan_interval
      when 'year'
      then (stripe_invoices.amount_due - GREATEST(stripe_invoices.starting_balance,0)) / 12 /100
      else (stripe_invoices.amount_due - GREATEST(stripe_invoices.starting_balance,0)) / 100
    end                                                   as amount
  from 
    {{ref('stripe_invoices')}} as stripe_invoices
  join
    {{ref('stripe_invoice_line_items')}} as invoice_line_items
  on
    invoice_line_items._sdc_source_key_id = stripe_invoices.id
)

select
  id                as id,
  max(amount)       as total
from
  stripe_invoices_with_line_items_year_adjusted
group by
  id