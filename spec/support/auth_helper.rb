module AuthHelper

  def basic_auth(name, pw)
    page.driver.browser.authorize(name, pw)
  end
end
