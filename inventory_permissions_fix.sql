-- Drop the old restrictive policy
DROP POLICY IF EXISTS "Allow all actions for authenticated users" ON public.inventory;

-- Create a new policy that allows both anonymous (anon) and logged-in (authenticated) users
-- This ensures the 'Failed to add unit' error is resolved if it was caused by permission issues.
CREATE POLICY "Allow all actions for all"
ON public.inventory
FOR ALL
TO anon, authenticated
USING (true)
WITH CHECK (true);
