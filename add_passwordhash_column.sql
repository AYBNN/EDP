-- Add a passwordhash column to the profiles table
ALTER TABLE public.profiles 
ADD COLUMN passwordhash text;

-- Warning: This column will be empty for existing users.
-- Also, Supabase does not automatically sync passwords here.
-- This is just a manual column for your reference if you populate it.
