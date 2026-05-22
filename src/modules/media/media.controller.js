import * as mediaService from './media.service.js'

export const createMedia = async (req, res, next) => {
  try {
    const result = await mediaService.createMedia(req.body)

    res.status(201).json({ success: true, data: result })
  } catch (err) {
    next(err)
  }
}

export const getMediaList = async (req, res, next) => {
  try {
    const result = await mediaService.getMediaList()

    res.json({ success: true, data: result })
  } catch (err) {
    next(err)
  }
}

export const getMedia = async (req, res, next) => {
  try {
    const result = await mediaService.getMedia(req.params.id)

    res.json({ success: true, data: result })
  } catch (err) {
    next(err)
  }
}

export const updateMedia = async (req, res, next) => {
  try {
    const result = await mediaService.updateMedia(req.params.id, req.body)

    res.json({ success: true, data: result })
  } catch (err) {
    next(err)
  }
}

export const deleteMedia = async (req, res, next) => {
  try {
    await mediaService.deleteMedia(req.params.id)

    res.json({ success: true, message: 'Eliminado correctamente' })
  } catch (err) {
    next(err)
  }
}

export const attachMediaToEntry = async (req, res, next) => {
  try {
    const result = await mediaService.attachMediaToEntry(req.body)

    res.status(201).json({ success: true, data: result })
  } catch (err) {
    next(err)
  }
}
