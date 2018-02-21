select 
  id               as id,
  amount           as amount,
  interval         as interval
from 
  {{ var('plans_table') }}