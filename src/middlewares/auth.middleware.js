import jwt from 'jsonwebtoken'
import { findUserById } from '../modules/auth/auth.model.js'

const JWT_SECRET = process.env.JWT_SECRET || 'dev_secret_change_in_production'

export const authenticate = async (req, res, next) => {
  try {
    const token = req.cookies?.token || req.headers.authorization?.startsWith('Bearer ') && req.headers.authorization.split(' ')[1]

    if (!token) {
      const err = new Error('Token no proporcionado')
      err.status = 401
      throw err
    }

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
    const token = req.cookies?.token || req.headers.authorization?.startsWith('Bearer ') && req.headers.authorization.split(' ')[1]

    if (!token) return next()

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
