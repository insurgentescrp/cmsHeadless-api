import { pool } from '../../config/db.js'

export const createUser = async ({ username, email, passwordHash, firstName, lastName }) => {
  const { rows } = await pool.query(
    `INSERT INTO users (username, email, password_hash, first_name, last_name)
     VALUES ($1, $2, $3, $4, $5)
     RETURNING id, username, email, first_name, last_name, is_active, is_superuser, created_at`,
    [username, email, passwordHash, firstName || null, lastName || null]
  )

  return rows[0]
}

export const findUserByEmail = async (email) => {
  const { rows } = await pool.query(
    'SELECT * FROM users WHERE email = $1 LIMIT 1',
    [email]
  )

  return rows[0]
}

export const findUserById = async (id) => {
  const { rows } = await pool.query(
    'SELECT id, username, email, first_name, last_name, is_active, is_superuser, created_at FROM users WHERE id = $1 LIMIT 1',
    [id]
  )

  return rows[0]
}
