Feature: Add migrations to the project

  Background:
    Given I have a project with Auther

  Scenario: Users table does not exist
    Given I successfully run `rails new my_app`
    #When I install the dependencies
    #And I successfully run `bundle exec rails generate auther:install`
    #And I successfully run `ls db/migrate`
    #Then the output should contain:
    #  """
    #  create_users.rb
    #  create_auther_authorizations.rb
    #  """
