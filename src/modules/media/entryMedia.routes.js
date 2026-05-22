import { Router } from 'express'
import * as mediaController from './media.controller.js'

const router = Router()

router.post('/', mediaController.attachMediaToEntry)

export default router
