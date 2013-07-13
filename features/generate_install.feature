Feature: Install the gem

  Background:
    Given I have a project with auther
    And I install the dependencies

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
