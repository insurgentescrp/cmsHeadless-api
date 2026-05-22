import * as authorService from './author.service.js'

export const createAuthor = async (req, res, next) => {
  try {
    const result = await authorService.createAuthor(req.body)

    res.status(201).json({ success: true, data: result })
  } catch (err) {
    next(err)
  }
}

export const getAuthors = async (req, res, next) => {
  try {
    const result = await authorService.getAuthors()

    res.json({ success: true, data: result })
  } catch (err) {
    next(err)
  }
}

export const getAuthor = async (req, res, next) => {
  try {
    const result = await authorService.getAuthor(req.params.id)

    res.json({ success: true, data: result })
  } catch (err) {
    next(err)
  }
}

export const updateAuthor = async (req, res, next) => {
  try {
    const result = await authorService.updateAuthor(req.params.id, req.body)

    res.json({ success: true, data: result })
  } catch (err) {
    next(err)
  }
}

export const deleteAuthor = async (req, res, next) => {
  try {
    await authorService.deleteAuthor(req.params.id)

    res.json({ success: true, message: 'Eliminado correctamente' })
  } catch (err) {
    next(err)
  }
}

export const addEntryAuthor = async (req, res, next) => {
  try {
    const result = await authorService.addEntryAuthor(req.body)

    res.status(201).json({ success: true, data: result })
  } catch (err) {
    next(err)
  }
}
