import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'
import * as authModel from './auth.model.js'

const JWT_SECRET = process.env.JWT_SECRET || 'dev_secret_change_in_production'
const SALT_ROUNDS = 10

export const register = async ({ username, email, password, firstName, lastName }) => {
  if (!username || !email || !password) {
    throw new Error('username, email y password son requeridos')
  }

  const existing = await authModel.findUserByEmail(email)
  if (existing) {
    const err = new Error('El email ya está registrado')
    err.status = 409
    throw err
  }

  const passwordHash = await bcrypt.hash(password, SALT_ROUNDS)

  const user = await authModel.createUser({
    username,
    email,
    passwordHash,
    firstName,
    lastName
  })

  const token = jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: '7d' })

  return { user, token }
}

export const login = async ({ email, password }) => {
  if (!email || !password) {
    throw new Error('email y password son requeridos')
  }

  const user = await authModel.findUserByEmail(email)
  if (!user) {
    const err = new Error('Credenciales inválidas')
    err.status = 401
    throw err
  }

  const valid = await bcrypt.compare(password, user.password_hash)
  if (!valid) {
    const err = new Error('Credenciales inválidas')
    err.status = 401
    throw err
  }

  const token = jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: '7d' })

  const { password_hash, ...safeUser } = user
  return { user: safeUser, token }
}

export const getProfile = async (userId) => {
  const user = await authModel.findUserById(userId)
  if (!user) {
    const err = new Error('Usuario no encontrado')
    err.status = 404
    throw err
  }

  return user
}
