source 'https://rubygems.org'
ruby '2.2.0'

gem 'rails', '4.2.5'
gem 'pg', '~> 0.18.4'

gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'turbolinks'
gem 'therubyracer'

group :development, :test do
  gem 'byebug'
end

group :development do
  #gem 'capistrano'
  gem 'capistrano-rvm',      require: false
  gem 'capistrano-rails',    require: false
  gem 'capistrano-bundler',  require: false
  gem 'capistrano3-puma',    require: false
  gem 'capistrano-db-tasks', require: false
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :assets do
  gem 'sass-rails', '~> 5.0.3'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.1.0'
  gem 'execjs'
end

gem 'bootstrap-sass'
gem 'devise'
#gem 'devise_invitable'
gem 'figaro'
gem 'high_voltage'
gem 'puma', '~> 2.15.3'

gem 'pundit'
#gem 'simple_form'
gem 'slim-rails'
gem 'foreman'

gem 'aws-sdk-v1'
gem 'aws-sdk', '~>2'


gem 'spree', '3.0.4'
gem 'spree_auth_devise',         github: 'spree/spree_auth_devise', branch: '3-0-stable'
gem 'spree_i18n',                github: 'spree-contrib/spree_i18n', branch: '3-0-stable'
gem 'spree_social_products',     github: 'spree/spree_social_products', branch: '3-0-stable'
#gem 'spree_sitemap',             github: 'jdutil/spree_sitemap', branch: '2-3-stable'
gem 'spree_static_content',      github: 'spree-contrib/spree_static_content', branch: '3-0-stable'
#gem 'spree_bank_transfer',       github: 'alvarosaavedra/spree_bank_transfer', branch: '3-0-stable', require: 'spree_bank_transfer'
gem 'spree_editor',              github: 'spree-contrib/spree_editor', branch: '3-0-stable'
gem 'spree_news',                github: 'EALeon/spree_news', branch: 'test_branch'
gem 'spree_comments',            github: 'spree-contrib/spree_comments', branch: '3-0-stable'
gem 'spree_sitemap',             github: 'spree-contrib/spree_sitemap', branch: '3-0-stable'

gem 'spree_paypal_express',      github: 'spree-contrib/better_spree_paypal_express', branch: '3-0-stable'

#gem 'spree_robokassa',           github: 'EALeon/spree_robokassa', branch: 'test_branch'

gem 'ckeditor', '~>4.1.6'

gem 'russian_post_calc',         github: 'shaggyone/russian_post_calc'
gem 'spree_russian_post_calc',   github: 'EALeon/spree_russian_post_calc', branch: 'test_branch'
gem 'spree_walletone',           github: 'ysynesis/spree_walletone'

group :development do
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring-commands-rspec'
  gem 'rack-mini-profiler', github: 'MiniProfiler/rack-mini-profiler', require: false
  gem "letter_opener", "~> 1.2.0"
  gem 'bullet', github: 'flyerhzm/bullet'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'rubocop'
end

#group :production do
#  gem 'rails_12factor'
#end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end
