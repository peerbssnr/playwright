import {test, expect} from '@playwright/test'
import exp from 'constants'


test(' My first test ', async ({page}) => {
    await page.goto("https://google.com")
    await expect(page).toHaveTitle('Google')
})