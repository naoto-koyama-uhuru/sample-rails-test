# README

- ここではgithub + herokuでrailsの環境を作成する手順を記載していきます

## GitHubの設定
- GitHubに新規リポジトリ```sample-rails-test```を作成する
- git clone
```bash
$ git clone https://github.com/naoto-koyama-uhuru/sample-rails-test.git
```

## Railsアプリケーションの作成
- 環境構築は除く
- 新しいプロジェクトの作成
```bash
$ cd sample-rails-test
$ rails new .
```
- RSpecの設定もしておく
  - Gemfile
```ruby
group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
end
```
```bash
$ bundle exec rails generate rspec:install
      create  .rspec
      create  spec
      create  spec/spec_helper.rb
      create  spec/rails_helper.rb
```
  - .rspec
```ruby
--require spec_helper
--format documentation
```


