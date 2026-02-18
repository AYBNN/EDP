-- Create the inventory table
CREATE TABLE IF NOT EXISTS public.inventory (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    model TEXT,
    manufacturer TEXT,
    serial TEXT,
    barcode TEXT,
    status TEXT NOT NULL CHECK (status IN ('Available', 'Checked Out', 'Broken', 'In Repair')),
    location TEXT,
    condition TEXT NOT NULL CHECK (condition IN ('Excellent', 'Good', 'Fair', 'Poor', 'Broken', 'Critical')),
    type TEXT NOT NULL CHECK (type IN ('Supplies', 'Small Machine', 'Electronics', 'Furniture', 'Computer')),
    last_adjust DATE,
    notes TEXT,
    checked_out_date DATE,
    return_due DATE,
    original_cost NUMERIC(15, 2),
    current_value NUMERIC(15, 2),
    image_url TEXT,
    activity JSONB DEFAULT '[]'::jsonb,
    checked_out_to JSONB DEFAULT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.inventory ENABLE ROW LEVEL SECURITY;

-- Create policy to allow all actions for authenticated users (Adjust as needed)
CREATE POLICY "Allow all actions for authenticated users"
ON public.inventory
FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);

-- Create a function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create a trigger to automatically update updated_at
CREATE TRIGGER update_inventory_updated_at
BEFORE UPDATE ON public.inventory
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();
