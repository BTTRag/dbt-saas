
  
    
  

  
    
  
    
  

  create  table "dbt_mktg"."stripe_invoice_line_items__dbt_tmp"
  
  
  as (
    select
  *,
  plan__interval as plan_interval,
  plan__id as plan_id
from
  vero_stripe_redo.stripe_invoices__lines__data
  );