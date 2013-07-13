Given(/^I have a project with Auther$/) do
  asd
  steps %Q{
    I successfully run `rails new /tmp/test_app --skip-bundle --skip-javascript --skip-sprockets`
    When I cd to "test_app"
    And I remove the file "public/index.html"
    And I remove the file "app/views/layouts/application.html.erb"
    And I configure ActionMailer to use "localhost" as a host
    And I configure a root route
    And I add the "auther" gem from this project
  }
end

When(/^I install the dependencies$/) do
  pending # express the regexp above with the code you wish you had
end

