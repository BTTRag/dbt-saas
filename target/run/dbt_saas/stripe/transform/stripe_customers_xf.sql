
  
    
  

  
    
  
    
  

  create  table "dbt_mktg"."stripe_customers_xf__dbt_tmp"
  
  
  as (
    select 
  *
from 
  "dbt_mktg"."stripe_customers"
  );