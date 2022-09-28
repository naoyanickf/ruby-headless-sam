require 'active_support/all'
require 'selenium-webdriver'

def hello(event:, context:)
  
  {
    statusCode: 200,
    body: {
      message: ScraperBase.test,
      input: event
    }.to_json
  }
end

class ScraperBase
  def self.initialize_selenium_driver(is_headless = true)
    service = Selenium::WebDriver::Service.chrome(path: '/opt/chromedriver/bin/chromedriver')
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 20 # seconds
    Selenium::WebDriver.for :chrome, service: service, options: driver_options, http_client: client
  end

  def self.driver_options
    options = Selenium::WebDriver::Chrome::Options.new(binary: '/opt/chromedriver/bin/headless-chromium')
    arguments = ["--headless"]
    arguments.each do |argument|
      options.add_argument(argument)
    end
    options
  end

  # 05:00 - 16:59
  def self.lunch?(datetime)
    t = Time.zone.parse(datetime)
    from = Time.zone.parse(t.strftime('%Y-%m-%d 05:00:00'))
    to = Time.zone.parse(t.strftime('%Y-%m-%d 16:59:59'))

    t.between?(from, to)
  end

  # 17:00 - 04:59
  def self.dinner?(datetime)
    t = Time.zone.parse(datetime)
    from = Time.zone.parse(t.strftime('%Y-%m-%d 17:00:00'))
    to = Time.zone.parse(t.tomorrow.strftime('%Y-%m-%d 04:59:59'))

    t.between?(from, to)
  end

  def self.test
    driver = initialize_selenium_driver
    driver.navigate.to "https://www.google.com"
    title = driver.title
    driver.quit

    title
  end
end

# 認証失敗用の例外
class ScraperAuthError < RuntimeError
end
