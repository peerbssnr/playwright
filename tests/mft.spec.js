import { test, expect } from '@playwright/test';

test('test', async ({ page }) => {
  await page.goto('https://azau1.mft-az-au.webmethods.io/mft/');
//   await page.getByLabel('Username').click();
//   await page.getByLabel('Username').fill('mftuser');
//   await page.getByLabel('Password').click();
//   await page.getByLabel('Password').fill('kKCfcbzQAM3S*PjF');
//   await page.getByRole('button', { name: 'Log in123' }).click();
//   await page.goto('https://azau1.mft-az-au.webmethods.io/mft/#/welcome');

  await page.locator("id=username").fill('mftuser')
  await page.pause()
});