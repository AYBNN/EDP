import fs from 'fs';
const env = fs.readFileSync('.env', 'utf-8').split('\n').reduce((acc, line) => {
    if (!line || line.startsWith('#')) return acc;
    const [k, ...v] = line.split('=');
    if (k) acc[k.trim()] = v.join('=').trim().replace(/['"]/g, '');
    return acc;
}, {});
const key = env.VITE_SUPABASE_ANON_KEY;
const headers = { 'apikey': key, 'Authorization': 'Bearer ' + key };

async function run() {
    for (const t of ['inventory', 'fixed_assets_inventory', 'consumables_inventory']) {
        try {
            const r = await fetch(env.VITE_SUPABASE_URL + '/rest/v1/' + t + '?select=id&limit=1', { headers });
            const d = await r.json();
            console.log(t, d);
        } catch (e) { console.error(e); }
    }
}
run();
