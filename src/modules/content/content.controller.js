// src/modules/content/content.controller.js

import * as contentService from './content.service.js'

export const createEntry = async (req, res, next) => {
  try {
    const { contentType } = req.params
    const data = req.body
    const userId = req.user?.id || null

    const result = await contentService.createEntry(contentType, data, userId)

    return res.status(201).json({
      success: true,
      data: result
    })
  } catch (error) {
    next(error)
  }
}

// GET /api/:contentType
export const getEntries = async (req, res, next) => {
  try {
    const { contentType } = req.params
    const query = req.query

    const result = await contentService.getEntries(contentType, query)

    return res.json({
      success: true,
      data: result
    })
  } catch (error) {
    next(error)
  }
}

// GET /api/:contentType/:id
export const getEntry = async (req, res, next) => {
  try {
    const { contentType, id } = req.params

    const result = await contentService.getEntry(contentType, id)

    return res.json({
      success: true,
      data: result
    })
  } catch (error) {
    next(error)
  }
}

export const updateEntry = async (req, res, next) => {
  try {
    const { contentType, id } = req.params
    const data = req.body
    const userId = req.user?.id || null

    const result = await contentService.updateEntry(contentType, id, data, userId)

    return res.json({
      success: true,
      data: result
    })
  } catch (error) {
    next(error)
  }
}

// DELETE /api/:contentType/:id
export const deleteEntry = async (req, res, next) => {
  try {
    const { contentType, id } = req.params

    await contentService.deleteEntry(contentType, id)

    return res.json({
      success: true,
      message: 'Entry eliminada correctamente'
    })
  } catch (error) {
    next(error)
  }
}
