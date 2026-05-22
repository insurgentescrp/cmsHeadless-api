import * as authService from './auth.service.js'

export const register = async (req, res, next) => {
  try {
    const result = await authService.register(req.body)

    res.status(201).json({
      success: true,
      data: result
    })
  } catch (err) {
    next(err)
  }
}

export const login = async (req, res, next) => {
  try {
    const result = await authService.login(req.body)

    res.json({
      success: true,
      data: result
    })
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
