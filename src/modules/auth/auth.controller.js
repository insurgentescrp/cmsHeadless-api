import * as authService from './auth.service.js'

export const register = async (req, res, next) => {
  try {
    const result = await authService.register(req.body)

    res.cookie('token', result.token, {
      httpOnly: true,
      secure: true,
      sameSite: 'none',
      maxAge: 7 * 24 * 60 * 60 * 1000
    })

    res.status(201).json({
      success: true,
      data: { user: result.user }
    })
  } catch (err) {
    next(err)
  }
}

export const login = async (req, res, next) => {
  try {
    const { token, user } = await authService.login(req.body)

    res.cookie('token', token, {
      httpOnly: true,
      secure: true,
      sameSite: 'none',
      maxAge: 7 * 24 * 60 * 60 * 1000
    })

    res.json({
      success: true,
      data: { user }
    })
  } catch (err) {
    next(err)
  }
}

export const logout = async (req, res, next) => {
  try {
    res.clearCookie('token', { httpOnly: true, secure: true, sameSite: 'none' })
    res.json({ success: true, data: { message: 'Sesión cerrada' } })
  } catch (err) {
    next(err)
  }
}

export const getProfile = async (req, res, next) => {
  try {
    const result = await authService.getProfile(req.user.id)

    res.json({
      success: true,
      data: result
    })
  } catch (err) {
    next(err)
  }
}
