select 
  id,
  email
from 
  {{ var('customers_table') }}