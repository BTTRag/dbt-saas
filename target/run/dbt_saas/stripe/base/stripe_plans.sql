
  
    
  

  
    
  
    
  

  create  table "dbt_mktg"."stripe_plans__dbt_tmp"
  
  
  as (
    select 
  id               as id,
  amount           as amount,
  interval         as interval
from 
  production.vero_stripe_redo.stripe_plans
  );