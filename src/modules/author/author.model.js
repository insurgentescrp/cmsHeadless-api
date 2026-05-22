import { pool } from '../../config/db.js'

export const createAuthor = async ({
  name, slug, bio, avatarUrl, email, role, twitter, instagram
}) => {
  const { rows } = await pool.query(
    `INSERT INTO authors (name, slug, bio, avatar_url, email, role, twitter, instagram)
     VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
     RETURNING *`,
    [name, slug, bio, avatarUrl, email, role, twitter, instagram]
  )
  return rows[0]
}

export const getAuthors = async () => {
  const { rows } = await pool.query(
    'SELECT * FROM authors ORDER BY name ASC'
  )
  return rows
}

export const getAuthorById = async (id) => {
  const { rows } = await pool.query(
    'SELECT * FROM authors WHERE id = $1 LIMIT 1',
    [id]
  )
  return rows[0]
}

export const updateAuthor = async (id, {
  name, slug, bio, avatarUrl, email, role, twitter, instagram
}) => {
  const { rows } = await pool.query(
    `UPDATE authors SET
       name = COALESCE($1, name),
       slug = COALESCE($2, slug),
       bio = COALESCE($3, bio),
       avatar_url = COALESCE($4, avatar_url),
       email = COALESCE($5, email),
       role = COALESCE($6, role),
       twitter = COALESCE($7, twitter),
       instagram = COALESCE($8, instagram),
       updated_at = NOW()
     WHERE id = $9
     RETURNING *`,
    [name, slug, bio, avatarUrl, email, role, twitter, instagram, id]
  )
  return rows[0]
}

export const deleteAuthor = async (id) => {
  await pool.query('DELETE FROM authors WHERE id = $1', [id])
}

export const addEntryAuthor = async ({ entryId, authorId, position }) => {
  const { rows } = await pool.query(
    `INSERT INTO entry_authors (entry_id, author_id, position)
     VALUES ($1, $2, $3)
     ON CONFLICT (entry_id, author_id) DO NOTHING
     RETURNING *`,
    [entryId, authorId, position ?? 0]
  )
  return rows[0]
}

export const getEntryAuthorsRaw = async (entryId) => {
  const { rows } = await pool.query(
    `SELECT a.*, ea.position
     FROM entry_authors ea
     JOIN authors a ON a.id = ea.author_id
     WHERE ea.entry_id = $1
     ORDER BY ea.position ASC`,
    [entryId]
  )
  return rows
}
