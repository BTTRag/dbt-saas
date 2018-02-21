select 
  *
from 
  {{ ref('stripe_charges') }}