require 'test/unit'
require 'selenium-webdriver'

require_relative 'create_random_account'

class TestRegistration < Test::Unit::TestCase
  include CreateRandomAccount

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_positive

    create_random_account

    expected_text = 'Ваша учётная запись активирована. Вы можете войти.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)

  end

  def test_logout
    create_random_account

    @driver.find_element(:class, 'logout').click

    sleep 3

    login_button =  @driver.find_element(:class, 'login')

    assert(login_button.displayed?)
    assert_equal('http://demo.redmine.org/', @driver.current_url)
  end



  def teardown
    @driver.quit
  end

end