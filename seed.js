// Use: MONGO_URI=mongodb://localhost:27017 node mongodb/seed.js
// Seed documents are synthetic and fictional.
import { MongoClient } from 'mongodb';
import { readFile } from 'node:fs/promises';
const uri=process.env.MONGO_URI||'mongodb://localhost:27017';
const client=new MongoClient(uri);const base=new URL('../data/',import.meta.url);
try{await client.connect();const db=client.db(process.env.MONGO_DB||'schraeder_demo');
for(const col of ['clinics','studies','services']){const data=JSON.parse(await readFile(new URL(col+'.json',base)));await db.collection(col).deleteMany({});await db.collection(col).insertMany(data);console.log(`Seeded ${col}: ${data.length}`);}}
finally{await client.close()}
