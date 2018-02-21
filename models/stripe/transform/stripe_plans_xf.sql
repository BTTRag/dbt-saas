select 
  *
from 
  {{ ref('stripe_plans') }}