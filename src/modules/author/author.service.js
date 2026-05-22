import * as authorModel from './author.model.js'

export const createAuthor = async (data) => {
  if (!data.name || !data.slug) {
    throw new Error('name y slug son requeridos')
  }

  return await authorModel.createAuthor({
    name: data.name,
    slug: data.slug,
    bio: data.bio || null,
    avatarUrl: data.avatarUrl || null,
    email: data.email || null,
    role: data.role || null,
    twitter: data.twitter || null,
    instagram: data.instagram || null
  })
}

export const getAuthors = async () => {
  return await authorModel.getAuthors()
}

export const getAuthor = async (id) => {
  const author = await authorModel.getAuthorById(id)

  if (!author) {
    const err = new Error('Autor no encontrado')
    err.status = 404
    throw err
  }

  return author
}

export const updateAuthor = async (id, data) => {
  const updated = await authorModel.updateAuthor(id, {
    name: data.name,
    slug: data.slug,
    bio: data.bio,
    avatarUrl: data.avatarUrl,
    email: data.email,
    role: data.role,
    twitter: data.twitter,
    instagram: data.instagram
  })

  if (!updated) {
    const err = new Error('Autor no encontrado')
    err.status = 404
    throw err
  }

  return updated
}

export const deleteAuthor = async (id) => {
  const author = await authorModel.getAuthorById(id)

  if (!author) {
    const err = new Error('Autor no encontrado')
    err.status = 404
    throw err
  }

  await authorModel.deleteAuthor(id)
}

export const addEntryAuthor = async (data) => {
  if (!data.entryId || !data.authorId) {
    throw new Error('entryId y authorId son requeridos')
  }

  return await authorModel.addEntryAuthor({
    entryId: data.entryId,
    authorId: data.authorId,
    position: data.position ?? 0
  })
}
