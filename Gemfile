source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'visualize_ruby', github: "zeisler/visualize_ruby"
# gem 'visualize_ruby', path: "../visualize_ruby"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.8.1'
gem 'actionpack'
# Use Puma as the app server
gem 'puma', '~> 4.3.12'
gem 'rack-cors'
gem 'rack-cache'
gem 'dalli'
gem 'kgio'
gem 'redis'
gem 'le'
gem 'ffi', "~> 1.16.3"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
  gem "pry"
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
