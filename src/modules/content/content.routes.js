import { Router } from 'express'
import * as contentController from './content.controller.js'
import { optionalAuth } from '../../middlewares/auth.middleware.js'

const router = Router()

router.post('/:contentType', optionalAuth, contentController.createEntry)
router.get('/:contentType', contentController.getEntries)
router.get('/:contentType/:id', contentController.getEntry)
router.patch('/:contentType/:id', optionalAuth, contentController.updateEntry)
router.delete('/:contentType/:id', contentController.deleteEntry)

export default router
