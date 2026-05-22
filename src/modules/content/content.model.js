// src/modules/content/content.model.js

import { pool } from '../../config/db.js'

export const getContentTypeByName = async (name) => {
  const { rows } = await pool.query(
    'SELECT * FROM content_types WHERE name = $1 LIMIT 1',
    [name]
  )

  return rows[0]
}

export const getFieldsByContentType = async (contentTypeId) => {
  const { rows } = await pool.query(
    `
    SELECT *
    FROM fields
    WHERE content_type_id = $1
    ORDER BY position ASC
    `,
    [contentTypeId]
  )

  return rows
}

export const createEntry = async ({
  contentTypeId,
  data,
  slug,
  status,
  createdBy
}) => {
  const { rows } = await pool.query(
    `
    INSERT INTO entries (content_type_id, data, slug, status, created_by)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING *
    `,
    [contentTypeId, data, slug, status, createdBy]
  )

  return rows[0]
}

export const getEntries = async (contentTypeId, query = {}) => {
  let sql = `
    SELECT *
    FROM entries
    WHERE content_type_id = $1
    AND deleted_at IS NULL
  `

  const values = [contentTypeId]
  let index = 2

  // 🔍 filtros dinámicos
  for (const key in query) {
    sql += ` AND data->>$${index} ILIKE $${index + 1}`
    values.push(key, `%${query[key]}%`)
    index += 2
  }

  sql += ' ORDER BY created_at DESC'

  const { rows } = await pool.query(sql, values)

  return rows
}

export const getEntryById = async (contentTypeId, id) => {
  const { rows } = await pool.query(
    `
    SELECT *
    FROM entries
    WHERE content_type_id = $1
    AND id = $2
    AND deleted_at IS NULL
    LIMIT 1
    `,
    [contentTypeId, id]
  )

  return rows[0]
}

export const updateEntry = async ({
  id,
  contentTypeId,
  data,
  slug,
  updatedBy
}) => {
  const { rows } = await pool.query(
    `
    UPDATE entries
    SET 
      data = data || $1,
      slug = COALESCE($2, slug),
      updated_by = COALESCE($5, updated_by),
      updated_at = NOW()
    WHERE id = $3
    AND content_type_id = $4
    AND deleted_at IS NULL
    RETURNING *
    `,
    [data, slug, id, contentTypeId, updatedBy]
  )

  return rows[0]
}

export const softDeleteEntry = async (id, contentTypeId) => {
  await pool.query(
    `
    UPDATE entries
    SET deleted_at = NOW()
    WHERE id = $1
    AND content_type_id = $2
    `,
    [id, contentTypeId]
  )
}
