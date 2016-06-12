require 'selenium-webdriver'
require 'test-unit'
driver = Selenium::WebDriver.for :firefox

wait = Selenium::WebDriver::Wait.new(:timeout => 10)

driver.navigate.to 'http://demo.redmine.org'
driver.find_element(:xpath, '//a[@class="register"]').click
wait.until{driver.find_element(:xpath, '//input[@id="user_login"]').displayed?}
driver.find_element(:xpath, '//input[@id="user_login"]').send_keys 'gfwfdsagfdas'
driver.find_element(:xpath, '//input[@id="user_password"]').send_keys 'gfdsagfdas'
driver.find_element(:xpath, '//input[@id="user_password_confirmation"]').send_keys 'gfdsagfdas'
driver.find_element(:xpath, '//input[@id="user_firstname"]').send_keys 'gfdsagfdas'
driver.find_element(:xpath, '//input[@id="user_lastname"]').send_keys 'gfdsagfdas'
driver.find_element(:xpath, '//input[@id="user_mail"]').send_keys 'gdzhd@sagfdas.com'
driver.find_element(:name, 'commit').click

sleep 5

rise unless driver.find_element(:id, 'flash_notice').text == 'Your account has been activated. You can now log in.'

driver.quit