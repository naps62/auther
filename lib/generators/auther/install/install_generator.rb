require 'rails/generators/base'
require 'rails/generators/active_record'

module Auther
  module Generators
    class InstallGenerator < Rails::Generators::Base

      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      def create_initializer
        binding.pry
        copy_file 'initializer.rb', 'config/initializers/auther.rb'
      end

      def create_controller
        if File.exists? 'app/controllers/application_controller.rb'
          inject_into ApplicationController, 'app/controllers/application_controller.rb', 'include Auther::Controller'
        else
          copy_file 'application_controller.rb', 'app/controllers/application_controller.rb'
        end
      end

      def create_models
        if File.exists? 'app/models/user.rb'
          inject_into User, 'app/models/user.rb', 'include Auther::User'
        else
          copy_file 'user.rb', 'app/models/user.rb'
        end
        copy_file 'authorization.rb', 'app/models/authorization.rb'
      end

      def create_authorization_migration
        create_migration 'create_authorizations.rb' # TODO check for name conflicts
      end

      def create_user_migration
        if users_table_exists?
          create_add_user_columns_migration
        else
          create_migration 'create_users.rb'
        end
      end

      def display_readme_in_terminal
        readme 'README'
      end

      private

      def create_add_user_columns_migration
        puts users_table_exists?
        if migration_needed?
          config = {
            new_columns: new_columns,
            new_indexes: new_indexes
          }
          create_migration 'add_author_to_users.rb', config
        end
      end

      def create_migration(migration_name, config = {})
        unless migration_exists?(migration_name)
          migration_template(
            "db/migrate/#{migration_name}",
            "db/migrate/#{migration_name}",
            config
          )
        end
      end

      def inject_into(class_name, file, text)
        if file_does_not_contain?(file, text)
          inject_into_class file, class_name, "  #{text}\n"
        end
      end

      def file_does_not_contain?(file, text)
        File.readlines(file).grep(/#{text}/).none?
      end

      def migration_needed?
        new_columns.any? || new_indexes.any?
      end

      def new_columns
        @new_columns ||= {
          email:              't.string :email',
          encrypted_password: 't.string :encrypted_password, :limit => 128',
          confirmation_token: 't.string :confirmation_token, :limit => 128',
          remember_token:     't.string :remember_token,     :limit => 128'
        }.reject { |column| existing_users_columns.include?(column.to_s) }
      end

      def new_indexes
        @new_indexes ||= {
          index_users_on_email:          'add_index :users, :email',
          index_users_on_remember_token: 'add_index :users, :remember_token'
        }.reject { |index| existing_users_indexes.include?(index.to_s) }
      end

      def migration_exists?(name)
        existing_migrations.include?(name)
      end

      def existing_migrations
        @existing_migrations ||= Dir.glob("db/migrate/*.rb").map do |file|
          migration_name_without_timestamp(file)
        end
      end

      def migration_name_without_timestamp(file)
        file.sub(%r{^.*(db/migrate/)(?:\d+_)?}, '')
      end

      def users_table_exists?
        ActiveRecord::Base.connection.table_exists?(:users)
      end

      def existing_users_columns
        ActiveRecord::Base.connection.columns(:users).map(&:name)
      end

      def existing_users_indexes
        ActiveRecord::Base.connection.indexes(:users).map(&:name)
      end

      # for generating a timestamp when using `create_migration`
      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end

    end
  end
end
