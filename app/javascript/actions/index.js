import loadTranslations from '../i18n'
import { BUILD_TRANSLATIONS } from '../packs/constants'

export const buildTranslations = (locale = 'en') => ({
  type: BUILD_TRANSLATIONS,
  payload: loadTranslations(locale)
})