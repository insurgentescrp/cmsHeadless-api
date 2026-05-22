import { Router } from 'express'
import * as authorController from './author.controller.js'

const router = Router()

router.post('/', authorController.createAuthor)
router.get('/', authorController.getAuthors)
router.get('/:id', authorController.getAuthor)
router.patch('/:id', authorController.updateAuthor)
router.delete('/:id', authorController.deleteAuthor)

export default router
