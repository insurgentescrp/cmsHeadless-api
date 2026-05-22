import { Router } from 'express'
import * as mediaController from './media.controller.js'

const router = Router()

router.post('/', mediaController.createMedia)
router.get('/', mediaController.getMediaList)
router.get('/:id', mediaController.getMedia)
router.patch('/:id', mediaController.updateMedia)
router.delete('/:id', mediaController.deleteMedia)

export default router
