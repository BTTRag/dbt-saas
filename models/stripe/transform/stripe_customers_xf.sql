select 
  *
from 
  {{ ref('stripe_customers') }}