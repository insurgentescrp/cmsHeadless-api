import { Router } from 'express'
import * as authorController from './author.controller.js'

const router = Router()

router.post('/', authorController.addEntryAuthor)

export default router
