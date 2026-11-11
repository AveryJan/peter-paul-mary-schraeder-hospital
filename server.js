import express from 'express';
import cors from 'cors';
import { MongoClient } from 'mongodb';
import { readFile } from 'node:fs/promises';
const app=express(); app.use(cors({origin:process.env.CORS_ORIGIN || 'http://localhost:5173'}));
const root=new URL('../data/',import.meta.url);
async function sample(name){return JSON.parse(await readFile(new URL(`${name}.json`,root),'utf8'));}
let db=null;
if(process.env.MONGO_URI){try{const client=new MongoClient(process.env.MONGO_URI);await client.connect();db=client.db(process.env.MONGO_DB||'schraeder_demo');console.log('MongoDB connected');}catch(err){console.error('Mongo unavailable; using synthetic fixtures:',err.message);}}
async function list(name){if(db){const docs=await db.collection(name).find({}, {projection:{_id:0}}).toArray();if(docs.length)return docs;}return sample(name);}
app.get('/health',(req,res)=>res.json({status:'ok',demo:true,database:db?'mongodb':'synthetic-fixtures'}));
for(const resource of ['clinics','studies','services']){app.get(`/api/${resource}`,async(req,res)=>{try{res.json(await list(resource));}catch(e){res.status(500).json({error:'Unable to load data'});}});}
app.get('/api/metrics',async(req,res)=>{try{res.json(await sample('metrics'));}catch(e){res.status(500).json({error:'Unable to load metrics'});}});
app.use((req,res)=>res.status(404).json({error:'Not found'}));
app.listen(Number(process.env.PORT||3001),()=>console.log('Schraeder demo API listening on port '+(process.env.PORT||3001)));
