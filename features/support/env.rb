require 'selenium-webdriver'
require 'capybara'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'site_prism'
require 'faker'

$env = ENV['BROWSER']
$headless = ENV['HEADLESS']

if $headless
  Capybara.register_driver :selenium do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
  end
end

Capybara.configure do |config|    
  if $env == 'chrome'
    config.default_driver = :selenium_chrome
  elsif $env == 'chrome_headless'
    config.default_driver = :selenium_chrome_headless
  else
    config.default_driver = :selenium
  end

  config.app_host = 'https://marktasks.herokuapp.com'
end

Capybara.default_max_wait_time = 5
