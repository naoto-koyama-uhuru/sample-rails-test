# README

- ここではgithub + herokuでrailsの環境を作成する手順を記載していきます

## GitHubの設定
- GitHubに新規リポジトリ```sample-rails-test```を作成する
- git clone
```bash
$ git clone https://github.com/naoto-koyama-uhuru/sample-rails-test.git
```

## Railsアプリケーションの作成

### プロジェクトの作成
- 環境構築は除く
- 新しいプロジェクトの作成
```bash
$ cd sample-rails-test
$ rails new .
```

### postgresの設定


### RSPECの設定
#### インストール
```Gemfile```
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

- テスト
```bash
$ bundle exec rspec
No examples found.

Randomized with seed 34242


Finished in 0.00111 seconds (files took 0.64233 seconds to load)
0 examples, 0 failures

Randomized with seed 34242
```

#### 設定
- 出力結果を見やすくする

```.rspec```
```ruby
--require spec_helper
--format documentation
```

- spec/support以下のファイルの読み込みができるようにする

```spec/rails_helper```
```rb
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f } # コメントアウトを外す
```

- TEST DBへMigrationを掛けていないときに自動でMigrationするのではなく、アラートを表示

```spec/rails_helper```
```rb
ActiveRecord::Migration.check_pending!
# begin
#   ActiveRecord::Migration.maintain_test_schema!
# rescue ActiveRecord::PendingMigrationError => e
#   puts e.to_s.strip
#   exit 1
# end
```
```bash
$ bundle exec rspec
・・・
Migrations are pending. To resolve this issue, run:

        bin/rails db:migrate RAILS_ENV=test
```

- Factory_botのメソッドの名前空間の省略

```spec/support/factory_bot.rb```
```
RSpec.configure do |config|
  config.include include FactoryBot::Syntax::Methods
end
```

```seeds.rb```
```rb
require 'factory_bot'
include FactoryBot::Syntax::Methods
FactoryBot.definition_file_paths = [ Rails.root.join('spec', 'factories') ]
FactoryBot.reload
```

```ruby
# 通常FactoryBotをつけないと、メソッドを呼べない
user = FactoryBot.create(:user)

# 上の設定を追加することで、FactoryBotの記述が省略できる。
user = create(:user)
```

- 現在時刻の時間をずらす(travel_to)

```spec/rails_helper```
```rb
config.include ActiveSupport::Testing::TimeHelpers # 追記
```

```rb
decsribe "Time.current" do
  it do
    travel_to('2018-12-16 8:00'.to_time) do
      expect(Time.current).to eq(Time.new(2018, 3, 10, 8, 0, 0))
    end
  end
end
```

- テスト実行毎にデータベースを初期化する

```Gemfile```
```rb
group :test do
  gem 'database_rewinder'
end
```
```spec/support/factory_bot.rb```
```rb
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseRewinder.clean_all
  end

  config.after(:each) do
    DatabaseRewinder.clean
  end
end
```

- テストの順番をランダムにする

```spec/spec_helper.rb```
```rb
config.order = :random # 最終行に追加
```
- 同じ順番を再現したい場合

```
$ bundle exec rspec
・・・
Randomized with seed 14925
$ rspec -fd --order rand:14925 # 実行結果のseedの番号を指定
```
