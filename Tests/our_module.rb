module OurModule
  def register_user
    @driver.navigate.to 'http://demo.redmine.org'
    @driver.find_element(:xpath, '//a[@class="register"]').click

    @wait.until{@driver.find_element(:xpath, '//input[@id="user_login"]').displayed?}

    login = ('login' + rand(999999).to_s)

    @driver.find_element(:xpath, '//input[@id="user_login"]').send_keys login
    @driver.find_element(:xpath, '//input[@id="user_password"]').send_keys 'gfdsagfdas'
    @driver.find_element(:xpath, '//input[@id="user_password_confirmation"]').send_keys 'gfdsagfdas'
    @driver.find_element(:xpath, '//input[@id="user_firstname"]').send_keys 'gfdsagfdas'
    @driver.find_element(:xpath, '//input[@id="user_lastname"]').send_keys 'gfdsagfdas'
    @driver.find_element(:xpath, '//input[@id="user_mail"]').send_keys (login + '@sagfdas.com')
    @driver.find_element(:name, 'commit').click
  end
end