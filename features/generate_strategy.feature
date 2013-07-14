Feature: Generating strategies

  Background:
    Given I have a project with auther
    And I install the dependencies
    And I successfully run `bundle exec rails generate auther:install`

  Scenario: Create a new strategy
    When I successfully run `bundle exec rails generate auther:strategy github`
    And  I successfully run `cat lib/auther/strategies/github.rb`
    Then the output should contain "class Github < Auther::Strategies::Base"
