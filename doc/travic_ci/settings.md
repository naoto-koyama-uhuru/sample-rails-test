# Travis CIの設定

## Sign Up

- https://travis-ci.org/ に接続
![](../../pic/travis_ci/sign_up.png)
- githubと連携することができるため、パスワードを入力して連携
![](../../pic/travis_ci/top.png)

## 連携の設定
- CIを設定したいリポジトリのトグルがオフになっているため、オンに設定
![](../../pic/travis_ci/toggle_on.png)

- configファイルを作成する
  - postgresはデフォルト9.2のため、9.6で作成

```.travis.yml```
```yml
language: ruby
rvm: 2.4.3
addons:
  postgresql: "9.6"
bundler_args: "--without development --deployment -j4"
cache: bundler
before_script:
  - cp config/database.travis.yml config/database.yml
  - bundle exec rails db:setup
script: bundle exec rspec

```

```config/database.travis.yml```
```yml
test:
  adapter: postgresql
  database: test
  username: postgres
```

- GitHubへpushすると、Build Historyから確認できる
![](../../pic/travis_ci/build_history1.png)
![](../../pic/travis_ci/build_history2.png)
![](../../pic/travis_ci/build_history3.png)

- GitHub上でも確認可能
![](../../pic/travis_ci/github_not_pass1.png)
![](../../pic/travis_ci/github_not_pass2.png)


## CIが通っていないとマージされないようにGitHub側の設定
- リポジトリのSettingsを選択
![](../../pic/travis_ci/github_settings.png)
- OptionsのBranchesを選択
![](../../pic/travis_ci/github_options1.png)
- Apply rule toに「master」を入力
- Rule settingsで
  - 「Require status checks to pass before merging」をチェック
  - 「Require branches to be up to date before merging」をチェック
  - 「continuous-integration/travis-ci」をチェック
![](../../pic/travis_ci/github_options2.png)

## バッジの設定
- travic ciでバッジを選択
![](../../pic/travis_ci/badge1.png)
- Status Imageが表示されるため、「Markdown」を選択して、READMEの先頭に表示されているタグをコピーしてpushしておく
![](../../pic/travis_ci/badge2.png)



