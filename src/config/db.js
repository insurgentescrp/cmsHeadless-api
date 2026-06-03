// src/config/db.js

import pkg from 'pg'
const { Pool } = pkg

export const DBconnect = {
  user: process.env.PGUSER || 'cms',
  password: process.env.PGPASSWORD || 'mi4v-aee3-5939',
  host: process.env.PGHOST || 'localhost',
  port: process.env.PGPORT || 5432,
  database: process.env.PGDATABASE || 'cms'
}

// Pool de conexiones
export const pool = new Pool(DBconnect)

// (opcional) test de conexión
pool.on('connect', () => {
  console.log('PostgreSQL conectado')
})

pool.on('error', (err) => {
  console.error('Error en PostgreSQL:', err)
})
