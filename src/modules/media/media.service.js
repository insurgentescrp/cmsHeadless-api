import * as mediaModel from './media.model.js'

export const createMedia = async (data) => {
  if (!data.externalUrl || !data.provider || !data.mediaType) {
    throw new Error('externalUrl, provider y mediaType son requeridos')
  }

  return await mediaModel.createMedia({
    externalUrl: data.externalUrl,
    provider: data.provider,
    mediaType: data.mediaType,
    title: data.title || null,
    caption: data.caption || null,
    alt: data.alt || null,
    credits: data.credits || null,
    width: data.width || null,
    height: data.height || null
  })
}

export const getMediaList = async () => {
  return await mediaModel.getMediaList()
}

export const getMedia = async (id) => {
  const media = await mediaModel.getMediaById(id)

  if (!media) {
    const err = new Error('Media no encontrado')
    err.status = 404
    throw err
  }

  return media
}

export const updateMedia = async (id, data) => {
  const updated = await mediaModel.updateMedia(id, {
    externalUrl: data.externalUrl,
    provider: data.provider,
    mediaType: data.mediaType,
    title: data.title,
    caption: data.caption,
    alt: data.alt,
    credits: data.credits,
    width: data.width,
    height: data.height
  })

  if (!updated) {
    const err = new Error('Media no encontrado')
    err.status = 404
    throw err
  }

  return updated
}

export const deleteMedia = async (id) => {
  const media = await mediaModel.getMediaById(id)

  if (!media) {
    const err = new Error('Media no encontrado')
    err.status = 404
    throw err
  }

  await mediaModel.deleteMedia(id)
}

export const attachMediaToEntry = async (data) => {
  if (!data.entryId || !data.mediaId) {
    throw new Error('entryId y mediaId son requeridos')
  }

  return await mediaModel.attachMediaToEntry({
    entryId: data.entryId,
    mediaId: data.mediaId,
    usage: data.usage ?? 'gallery',
    position: data.position ?? 0
  })
}
