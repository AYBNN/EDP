import dotenv from 'dotenv';
import { createClient } from '@supabase/supabase-js';
dotenv.config();
const supabase = createClient(process.env.VITE_SUPABASE_URL, process.env.VITE_SUPABASE_ANON_KEY);

async function run() {
    const { data } = await supabase.from('fixed_assets_inventory').select('id, name, image_url');
    console.log(data.filter(i => i.name.includes('Secure')));
}
run();
