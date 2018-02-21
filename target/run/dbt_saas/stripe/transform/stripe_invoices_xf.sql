
  
    
  

  
    
  
    
  

  create  table "dbt_mktg"."stripe_invoices_xf__dbt_tmp"
  
  
  as (
    with 

stripe_invoices_with_line_items as (
  select 
    * 
  from 
    "dbt_mktg"."stripe_invoices_with_line_items_xf_aggregated"
)

select 
  stripe_invoices.id                              as id,
  stripe_invoices.customer                        as customer,
  stripe_customers_xf.email                       as customer_email,
  stripe_invoices.date                            as date,
  stripe_invoices.period_end                      as period_end,
  stripe_invoices.forgiven                        as forgiven,
  stripe_invoices.subscription                    as subscription,
  stripe_invoices.paid                            as paid,
  stripe_invoices_with_line_items.total           as total,
  row_number() over(
    partition by stripe_invoices.customer 
    order by stripe_invoices.date desc
  )                                               as last_payment,
  row_number() over(
    partition by stripe_invoices.customer 
    order by stripe_invoices.date asc
  )                                               as first_payment
from 
  "dbt_mktg"."stripe_invoices" stripe_invoices
left outer join
  stripe_invoices_with_line_items
on
  stripe_invoices.id = stripe_invoices_with_line_items.id
left outer join
  "dbt_mktg"."stripe_customers_xf" as stripe_customers_xf
on
  stripe_customers_xf.id = stripe_invoices.customer
  );