
  
    
  

  
    
  

  create view "dbt_mktg"."invoices__dbt_tmp" as (
    with

stripe_invoices as (
  select
    id                            as invoice_id,
    customer                      as customer_id,
    customer_email                as customer_name,
    date                          as date,
    paid                          as paid,
    forgiven                      as forgiven,
    subscription                  as subscription_id,
    total                         as total,
    'stripe'                      as provider
  from
    "dbt_mktg"."stripe_invoices_xf"
)

select
  *
from
  stripe_invoices
  ) ;