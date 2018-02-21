select 
  amount,
  amount_refunded,
  refunded,
  id,
  customer,
  created
from 
  {{ var('charges_table') }}