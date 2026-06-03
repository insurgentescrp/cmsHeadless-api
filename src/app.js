import express from 'express'
import path from 'path'
import { fileURLToPath } from 'url'
import cookieParser from 'cookie-parser'
import cors from 'cors'
import contentRoutes from './modules/content/content.routes.js'
import { errorHandler } from './middlewares/error.middleware.js'
import contentTypeRoutes from './modules/contentType/contentType.routes.js'
import fieldRoutes from './modules/field/field.routes.js'
import authRoutes from './modules/auth/auth.routes.js'
import authorRoutes from './modules/author/author.routes.js'
import entryAuthorRoutes from './modules/author/entryAuthor.routes.js'
import mediaRoutes from './modules/media/media.routes.js'
import entryMediaRoutes from './modules/media/entryMedia.routes.js'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const app = express()

app.use(express.json())
app.use(cookieParser())
app.use(express.static(path.join(__dirname, '..', 'public')))

app.use(cors({
  origin: ['https://cms-headless-admin.vercel.app', 'https://insurgentesnews.vercel.app', 'https://www.insurgentescrp.com', 'https://insurgentescrp.com', 'https://insurgentes-news.vercel.app', 'http://localhost:3000'],
  credentials: true
}))

app.use('/api/auth', authRoutes)
app.use('/api/content-types', contentTypeRoutes)
app.use('/api/fields', fieldRoutes)
app.use('/api/authors', authorRoutes)
app.use('/api/entry-authors', entryAuthorRoutes)
app.use('/api/media', mediaRoutes)
app.use('/api/entry-media', entryMediaRoutes)
app.use('/api', contentRoutes)

app.use(errorHandler)

export default app
