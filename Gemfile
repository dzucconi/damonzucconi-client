# frozen_string_literal: true

ruby '2.6.3'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'actionpack-action_caching'
gem 'autoprefixer-rails'
gem 'puma', '~> 4.3'
gem 'rails', '~> 5.2.0'
gem 'sass-rails', github: 'rails/sass-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 4.x'

# TODO: Investigate:
# Updating graphql-client causes problems with its underlying graphql dependency
# Versions are pinned for this reason
gem 'graphql', '1.9.7'
gem 'graphql-client', '0.14.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'foreman'
  gem 'rubocop'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'heroku-deflater'
  gem 'rails_12factor'
end
