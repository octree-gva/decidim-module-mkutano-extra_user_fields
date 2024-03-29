# frozen_string_literal: true

require "decidim/dev/common_rake"

def install_module(path)
  Dir.chdir(path) do
    # system("bundle exec rake decidim_vocacity_gem_tasks:install:migrations")
  end
end

def seed_db(path)
  Dir.chdir(path) do
    system("bundle exec rake db:seed")
  end
end

desc "Prepare for testing"
task :prepare_tests do
  # Remove previous existing db, and recreate one.
  disable_docker_compose = ENV.fetch("DISABLED_DOCKER_COMPOSE", "false") == "true"
  unless disable_docker_compose
    system("docker-compose down -v")
    system("docker-compose up -d --remove-orphans")
  end
  ENV["RAILS_ENV"] = "test"
  databaseYml = {
    "test" => {
      "adapter" => "postgresql",
      "encoding" => "unicode",
      "host" => ENV.fetch("DATABASE_HOST", "localhost"),
      "port" => ENV.fetch("DATABASE_PORT", "5432").to_i,
      "username" => ENV.fetch("DATABASE_USERNAME", "decidim"),
      "password" => ENV.fetch("DATABASE_PASSWORD", "TEST-aWLIRsv8QHhxTFNqRb7EScj8erNSdDTYs0vpZ8jE6rwK"),
      "database" => "decidim_test"
    }
  }
  config_file = File.expand_path("spec/dummy/config/database.yml", __dir__)
  File.open(config_file, "w") { |f| YAML.dump(databaseYml, f) }
  Dir.chdir("spec/dummy") do
     system("bundle exec rails db:migrate")
   end
end
desc "Prepare for dev"
task :prepare_dev do
  # Remove previous existing db, and recreate one.
  disable_docker_compose = ENV.fetch("DISABLED_DOCKER_COMPOSE", "false") == "true"
  unless disable_docker_compose
    system("docker-compose down -v")
    system("docker-compose up -d --remove-orphans")
  end
  ENV["RAILS_ENV"] = "development"
  databaseYml = {
    "development" => {
      "adapter" => "postgresql",
      "encoding" => "unicode",
      "host" => ENV.fetch("DATABASE_HOST", "localhost"),
      "port" => ENV.fetch("DATABASE_PORT", "5432").to_i,
      "username" => ENV.fetch("DATABASE_USERNAME", "decidim"),
      "password" => ENV.fetch("DATABASE_PASSWORD", "TEST-aWLIRsv8QHhxTFNqRb7EScj8erNSdDTYs0vpZ8jE6rwK"),
      "database" => "decidim_test"
    }
  }
  config_file = File.expand_path("development_app/config/database.yml", __dir__)
  File.open(config_file, "w") { |f| YAML.dump(databaseYml, f) }
  Dir.chdir("development_app") do
     system("bundle exec rails db:migrate")
   end
end

desc "Generates a dummy app for testing"
task :test_app do
  Bundler.with_original_env do
    generate_decidim_app(
      "spec/dummy",
        "--app_name",
        "decidim_test",
        "--path",
        "../..",
        "--skip_spring",
        "--demo",
        "--force_ssl",
        "false",
        "--locales",
        "en,fr,es"
    )
  end
  install_module("spec/dummy")
  Rake::Task["prepare_tests"].invoke
end

desc "Generates a development app"
task :development_app do
  Bundler.with_original_env do
    generate_decidim_app(
      "development_app",
      "--app_name",
      "#{base_app_name}_development_app",
      "--path",
      ".."
    )
  end

  install_module("development_app")
  Rake::Task["prepare_dev"].invoke
end
