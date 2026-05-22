import jwt from 'jsonwebtoken'
import { findUserById } from '../modules/auth/auth.model.js'

const JWT_SECRET = process.env.JWT_SECRET || 'dev_secret_change_in_production'

export const authenticate = async (req, res, next) => {
  try {
    const header = req.headers.authorization

    if (!header || !header.startsWith('Bearer ')) {
      const err = new Error('Token no proporcionado')
      err.status = 401
      throw err
    }

    const token = header.split(' ')[1]
    const decoded = jwt.verify(token, JWT_SECRET)
    const user = await findUserById(decoded.id)

    if (!user) {
      const err = new Error('Usuario no encontrado')
      err.status = 401
      throw err
    }

    req.user = user
    next()
  } catch (err) {
    if (err.name === 'JsonWebTokenError' || err.name === 'TokenExpiredError') {
      err.status = 401
      err.message = 'Token inválido o expirado'
    }
    next(err)
  }
}

export const optionalAuth = async (req, res, next) => {
  try {
    const header = req.headers.authorization

    if (!header || !header.startsWith('Bearer ')) {
      return next()
    }

    const token = header.split(' ')[1]
    const decoded = jwt.verify(token, JWT_SECRET)
    const user = await findUserById(decoded.id)

    if (user) {
      req.user = user
    }

    next()
  } catch {
    next()
  }
}
