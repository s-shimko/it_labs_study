require 'test/unit'
require 'selenium-webdriver'

require_relative 'create_random_account'

class TestRegistration < Test::Unit::TestCase
  include CreateRandomAccount

  def setup
    @driver = Selenium::WebDriver.for :firefox
    # @driver = Selenium::WebDriver.for :chrome
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)

    # create_participant
#Fork#Fork#Fork#Fork#Fork#Fork#Fork#Fork#Fork#Fork#Fork#Fork#Fork

  end

  def test_registration
    create_random_account
    expected_text = 'Ваша учётная запись активирована. Вы можете войти.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def test_login_logout
    create_random_account
    @driver.find_element(:class, 'logout').click
    @wait.until{@driver.find_element(:xpath, '//a[@class="login"]').displayed?}
    @driver.find_element(:class, 'login').click
    @driver.find_element(:id, 'username').send_keys(@login)
    @driver.find_element(:id, 'password').send_keys('1234')
    @driver.find_element(:xpath, '//input[@type="submit"]').click
    name_after_login = @driver.find_element(:xpath, '//a[.="'+ @login + '"]')
    assert(name_after_login.displayed?)
  end

  def test_change_pwd
    create_random_account
    @driver.find_element(:xpath, '//a[contains(.,"Изменить пароль")]').click
    @driver.find_element(:name, 'password').send_keys('1234')
    @driver.find_element(:name, 'new_password').send_keys('12345')
    @driver.find_element(:name, 'new_password_confirmation').send_keys('12345')
    @driver.find_element(:name, 'commit').click
    expected_text = 'Пароль успешно обновлён.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def test_create_project
    create_random_account
    @driver.find_element(:class, 'projects').click
    @driver.find_element(:xpath, '//a[@class="icon icon-add"]').click
    @driver.find_element(:id, 'project_name').send_keys(@login)
    @driver.find_element(:id, 'project_identifier').send_keys(@login)
    @driver.find_element(:name, 'commit').click
    confirmation_message = @driver.find_element(:xpath, '//div[.="Создание успешно."]')
    assert(confirmation_message.displayed?)
  end

  def test_add_participant
    create_random_account
    @driver.find_element(:class, 'logout').click
    @wait.until{@driver.find_element(:xpath, '//a[@class="register"]').displayed?}
    create_participant
    @driver.find_element(:class, 'logout').click
    @wait.until{@driver.find_element(:xpath, '//a[@class="login"]').displayed?}
    @driver.find_element(:xpath, '//a[@class="login"]').click
    @driver.find_element(:id, 'username').send_keys(@login)
    @driver.find_element(:id, 'password').send_keys('1234')
    @driver.find_element(:xpath, '//input[@type="submit"]').click
    @driver.find_element(:class, 'projects').click
    @driver.find_element(:xpath, '//a[@class="icon icon-add"]').click
    @driver.find_element(:xpath, '//input[@id="project_name"]').send_keys(@login)
    @driver.find_element(:name, 'commit').click
    @driver.find_element(:id, 'tab-members').click
    @driver.find_element(:xpath, '//a[.="Новый участник"]').click
    @wait.until{@driver.find_element(:xpath, '//input[@id="principal_search"]').displayed?}
    @driver.find_element(:xpath, '//input[@id="principal_search"]').send_keys(@lizard_firstname + ' ' + @lizard_lastname)
    @wait.until{@driver.find_element(:xpath, '//label[contains(.,"'+@lizard_firstname +' '+ @lizard_lastname+'")]/input[@type="checkbox"]').displayed?}
    @driver.find_element(:xpath, '//label[contains(.,"'+@lizard_firstname +' '+ @lizard_lastname+'")]/input[@type="checkbox"]').click
    @wait.until{@driver.find_element(:xpath, '(//label[contains(.,"Developer")]/input[@type="checkbox"])[2]').displayed?}
    @driver.find_element(:xpath, '(//label[contains(.,"Developer")]/input[@type="checkbox"])[2]').click
    @wait.until{@driver.find_element(:id, 'member-add-submit').displayed?}
    @driver.find_element(:id, 'member-add-submit').click
    added_username = @driver.find_element(:xpath, '//label[contains(.,"'+@lizard_firstname +' '+ @lizard_lastname+'")]/input[@type="checkbox"]')
    @wait.until{@driver.find_element(:xpath, '//label[contains(.,"'+@lizard_firstname +' '+ @lizard_lastname+'")]/input[@type="checkbox"]').displayed?}
    assert(added_username.displayed?)

  end

  def test_edit_participant_role
    create_random_account
    @driver.find_element(:class, 'logout').click
    @wait.until{@driver.find_element(:xpath, '//a[@class="register"]').displayed?}
    create_participant
    @driver.find_element(:class, 'logout').click
    @wait.until{@driver.find_element(:xpath, '//a[@class="login"]').displayed?}
    @driver.find_element(:xpath, '//a[@class="login"]').click
    @driver.find_element(:id, 'username').send_keys(@login)
    @driver.find_element(:id, 'password').send_keys('1234')
    @driver.find_element(:xpath, '//input[@type="submit"]').click
    @driver.find_element(:class, 'projects').click
    @driver.find_element(:xpath, '//a[@class="icon icon-add"]').click
    @driver.find_element(:xpath, '//input[@id="project_name"]').send_keys(@login)
    @driver.find_element(:name, 'commit').click
    @driver.find_element(:id, 'tab-members').click
    @driver.find_element(:xpath, '//a[.="Новый участник"]').click
    @wait.until{@driver.find_element(:xpath, '//input[@id="principal_search"]').displayed?}
    @driver.find_element(:xpath, '//input[@id="principal_search"]').send_keys(@lizard_firstname + ' ' + @lizard_lastname)
    @wait.until{@driver.find_element(:xpath, '//label[contains(.,"'+@lizard_firstname +' '+ @lizard_lastname+'")]/input[@type="checkbox"]').displayed?}
    @driver.find_element(:xpath, '//label[contains(.,"'+@lizard_firstname +' '+ @lizard_lastname+'")]/input[@type="checkbox"]').click
    @wait.until{@driver.find_element(:xpath, '(//label[contains(.,"Developer")]/input[@type="checkbox"])[2]').displayed?}
    @driver.find_element(:xpath, '(//label[contains(.,"Developer")]/input[@type="checkbox"])[2]').click
    @wait.until{@driver.find_element(:id, 'member-add-submit').displayed?}
    @driver.find_element(:id, 'member-add-submit').click
    @wait.until{@driver.find_element(:xpath, '//a[contains(.,"'+ @firstname+ ' ' + @lastname + '")]/ancestor::tr//a[contains(.,"Редактировать")]').displayed?}

    #//a[contains(.,"lizard_name82710 lizard_lastname684325")]/ancestor::tr
    sleep 1
    @driver.find_element(:xpath, '//a[contains(.,"'+ @firstname+ ' ' + @lastname + '")]/ancestor::tr//a[contains(.,"Редактировать")]').click
    @driver.find_element(:xpath, '//a[contains(.,"'+ @firstname+ ' ' + @lastname + '")]/ancestor::tr//label[contains(.,"Reporter")]/input[@type="checkbox"]').click
    @driver.find_element(:xpath, '//a[contains(.,"'+ @firstname+ ' ' + @lastname + '")]/ancestor::tr//input[@class="small"]').click
     # @wait.until(@driver.find_element(:xpath, '//a[contains(.,"' + @firstname + ' ' + @lastname + '")]/ancestor::tr//span[contains(.,"Reporter")]').displayed?)
     sleep 1
    role = @driver.find_element(:xpath, '//a[contains(.,"'+ @firstname+ ' ' + @lastname + '")]/ancestor::tr//span[contains(.,"Reporter")]')
    assert(role.displayed?)
  end

  def test_create_project_version
    create_random_account
    @driver.find_element(:class, 'projects').click
    @driver.find_element(:xpath, '//a[@class="icon icon-add"]').click
    @driver.find_element(:xpath, '//input[@id="project_name"]').send_keys(@login)
    @driver.find_element(:name, 'commit').click
    @driver.find_element(:id, 'tab-versions').click
    @driver.find_element(:xpath, '//a[contains(.,"Новая версия")]').click
    @driver.find_element(:id, 'version_name').send_keys(@firstname)
    @driver.find_element(:xpath, '//input[@type="submit"]').click
    message = @driver.find_element(:xpath, '//div[@id="flash_notice"][contains(.,"Создание успешно.")]')
    assert(message.displayed?)
  end

  def test_create_issues
    create_random_account
    puts @login
    @driver.find_element(:class, 'projects').click
    @driver.find_element(:xpath, '//a[@class="icon icon-add"]').click
    @driver.find_element(:id, 'project_name').send_keys(@login)
    @driver.find_element(:id, 'project_identifier').send_keys(@login)
    @driver.find_element(:name, 'commit').click
    @driver.find_element(:xpath, '//a[@class="new-issue"]').click
    dropdown = @driver.find_element(:id, 'issue_tracker_id')
    select_list = Selenium::WebDriver::Support::Select.new(dropdown)
    select_list.select_by(:text, 'Feature')
    @driver.find_element(:id, 'issue_subject').send_keys('Lizards issue' + rand(100).to_s)
    @driver.find_element(:name, 'commit').click
    @driver.find_element(:xpath, '//a[@class="new-issue"]').click
    dropdown = @driver.find_element(:id, 'issue_tracker_id')
    select_list = Selenium::WebDriver::Support::Select.new(dropdown)
    select_list.select_by(:text, 'Support')
    @driver.find_element(:id, 'issue_subject').send_keys('Lizards issue' + rand(100).to_s)
    @driver.find_element(:name, 'commit').click
    @driver.find_element(:xpath, '//a[@class="new-issue"]').click
    dropdown = @driver.find_element(:id, 'issue_tracker_id')
    select_list = Selenium::WebDriver::Support::Select.new(dropdown)
    select_list.select_by(:text, 'Bug')
    @driver.find_element(:id, 'issue_subject').send_keys('Lizards issue' + rand(100).to_s)
    @driver.find_element(:name, 'commit').click
    @driver.find_element(:xpath, '//a[@class="issues selected"]').click
    support_issue = @driver.find_element(:xpath, '//td[.="Support"]')
    assert(support_issue.displayed?)
    feature_issue = @driver.find_element(:xpath, '//td[.="Feature"]')
    assert(feature_issue.displayed?)
    bug_issue = @driver.find_element(:xpath, '//td[.="Bug"]')
    assert(bug_issue.displayed?)
    sleep 5

  end

  def teardown
    @driver.quit
  end
end
