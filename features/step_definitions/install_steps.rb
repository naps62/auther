Given(/^I have a project with auther$/) do
  steps %Q{
    Given I successfully run `rails new testapp --skip-bundle --skip-javascript --skip-sprockets`
    And I cd to "testapp"
    And I remove the file "app/views/layouts/application.html.erb"
    And I configure a root route
    And I add the "auther" gem to this project
  }
end

Given(/^I configure a root route$/) do
  route = "root to: 'home#show'"
  path = 'config/routes.rb'
  in_current_dir do
    add_to_file(path, /(\.routes\.draw do)/, route)
  end
end

Given(/^I install the dependencies$/) do
  step 'I successfully run `bundle install --local`'
end

When(/^I create a simple user migration$/) do
  steps %Q{
    When I write to "db/migrate/001_create_users.rb" with:
    """
    class CreateUsers < ActiveRecord::Migration
      def change
        create_table :users do |t|
          t.string :email
          t.string :name
        end
      end
    end
    """
  }
end

When(/^I create a user migration with all auther fields$/) do
  steps %Q{
    When I write to "db/migrate/001_create_fake_users.rb" with:
      """
      class CreateFakeUsers < ActiveRecord::Migration
        def self.up
          create_table :users  do |t|
            t.timestamps :null => false
            t.string :email, :null => false
            t.string :encrypted_password, :limit => 128, :null => false
            t.string :confirmation_token, :limit => 128
            t.string :remember_token, :limit => 128, :null => false
          end

          add_index :users, :email
          add_index :users, :remember_token
        end

        def self.down
          drop_table :users
        end
      end
      """
  }
end

When(/^I create a simple user model$/) do
  steps %Q{
    When I write to "app/models/user.rb" with:
    """
    class User < ActiveRecord::Base
      def original_user_method
        "dummy"
      end
    end
    """
  }
end
