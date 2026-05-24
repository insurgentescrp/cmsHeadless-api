// src/config/db.js

import pkg from 'pg'
const { Pool } = pkg

export const DBconnect = {
  user: 'cms',
  password: 'mi4v-aee3-5939',
  host: 'localhost',
  port: 5432,
  database: 'cms'
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
