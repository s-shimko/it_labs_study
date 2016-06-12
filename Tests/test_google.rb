require 'test/unit'
require 'selenium-webdriver'

class TestGoogle < Test::Unit::TestCase
  def setup
    @browser = Selenium::WebDriver.for :firefox
  end

  def test_google
    @browser.navigate.to 'https://www.google.com'
    assert(search_input.displayed?)
  end

  def search_input
    @browser.find_element(:name, 'q')
  end

  def teardown
    @browser.quit
  end
end