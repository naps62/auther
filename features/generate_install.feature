Feature: Installing auther

  Background:
    Given I have a project with auther
    And I install the dependencies

  Scenario: The user model is installed
    When I successfully run `bundle exec rails generate auther:install`
    And  I successfully run `cat app/models/user.rb`
    Then the output should contain "include Auther::Model"

  Scenario: The user model is updated if it already exists
    When I create a simple user model
    When I successfully run `bundle exec rails generate auther:install`
    And  I successfully run `cat app/models/user.rb`
    Then the output should contain "def original_user_method"
    Then the output should contain "include Auther::Model"

  Scenario: The application controller is updated
    When I successfully run `bundle exec rails generate auther:install`
    And  I successfully run `cat app/controllers/application_controller.rb`
    Then the output should contain "include Auther::Controller"

  Scenario: Users table does not exist
    When I successfully run `bundle exec rails generate auther:install`
    And  I successfully run `ls db/migrate`
    Then the output should contain "create_users.rb"

  Scenario: Users table does not exist
    When I create a simple user migration
    And  I successfully run `bundle exec rake db:migrate`
    And  I successfully run `bundle exec rails generate auther:install`
    And  I successfully run `ls db/migrate`
    Then the output should contain "add_auther_to_users.rb"

  Scenario: Users table with existing auther fields
    When I create a user migration with all auther fields
    And  I successfully run `bundle exec rake db:migrate`
    And  I successfully run `bundle exec rails generate auther:install`
    And  I successfully run `ls db/migrate`
    Then the output should not contain "create_users.rb"
    And  the output should not contain "add_auther_to_users.rb"
