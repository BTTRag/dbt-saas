
  
    
  

  
    
  
    
  

  create  table "dbt_mktg"."stripe_customers__dbt_tmp"
  
  
  as (
    select 
  id,
  email
from 
  production.vero_stripe_redo.stripe_customers
  );