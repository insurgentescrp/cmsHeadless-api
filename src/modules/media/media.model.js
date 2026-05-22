import { pool } from '../../config/db.js'

export const createMedia = async ({
  externalUrl, provider, mediaType, title, caption, alt, credits, width, height
}) => {
  const { rows } = await pool.query(
    `INSERT INTO media (external_url, provider, media_type, title, caption, alt, credits, width, height)
     VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
     RETURNING *`,
    [externalUrl, provider, mediaType, title, caption, alt, credits, width, height]
  )
  return rows[0]
}

export const getMediaList = async () => {
  const { rows } = await pool.query(
    'SELECT * FROM media ORDER BY created_at DESC'
  )
  return rows
}

export const getMediaById = async (id) => {
  const { rows } = await pool.query(
    'SELECT * FROM media WHERE id = $1 LIMIT 1',
    [id]
  )
  return rows[0]
}

export const updateMedia = async (id, {
  externalUrl, provider, mediaType, title, caption, alt, credits, width, height
}) => {
  const { rows } = await pool.query(
    `UPDATE media SET
       external_url = COALESCE($1, external_url),
       provider = COALESCE($2, provider),
       media_type = COALESCE($3, media_type),
       title = COALESCE($4, title),
       caption = COALESCE($5, caption),
       alt = COALESCE($6, alt),
       credits = COALESCE($7, credits),
       width = COALESCE($8, width),
       height = COALESCE($9, height),
       updated_at = NOW()
     WHERE id = $10
     RETURNING *`,
    [externalUrl, provider, mediaType, title, caption, alt, credits, width, height, id]
  )
  return rows[0]
}

export const deleteMedia = async (id) => {
  await pool.query('DELETE FROM media WHERE id = $1', [id])
}

export const attachMediaToEntry = async ({ entryId, mediaId, usage, position }) => {
  const { rows } = await pool.query(
    `INSERT INTO entry_media (entry_id, media_id, usage, position)
     VALUES ($1, $2, $3, $4)
     RETURNING *`,
    [entryId, mediaId, usage ?? 'gallery', position ?? 0]
  )
  return rows[0]
}

export const getEntryMediaRaw = async (entryId) => {
  const { rows } = await pool.query(
    `SELECT m.*, em.usage, em.position
     FROM entry_media em
     JOIN media m ON m.id = em.media_id
     WHERE em.entry_id = $1
     ORDER BY em.position ASC`,
    [entryId]
  )
  return rows
}
