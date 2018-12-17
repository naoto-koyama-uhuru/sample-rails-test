# Heroku Review Appsの設定

- herokuの作成したapplicationからDeployタブを選択し、GitHub連携を行う
![](../../pic/heroku/deploy1.png)
![](../../pic/heroku/deploy2.png)

- Add this app to a pipelineから「Choose a pipline」を選択し、「Create new pipline」をクリックする
  - Name the piplineを入力して、「Create pipline」ボタンを押下
![](../../pic/heroku/deploy3.png)
![](../../pic/heroku/deploy4.png)

- Piplineの設定画面で、「Enable Review apps」を選択
![](../../pic/heroku/deploy5.png)
![](../../pic/heroku/deploy6.png)

- Scriptに```bundle exec rails db:migrate```と入力
![](../../pic/heroku/deploy7.png)

- 確認画面で「Create new review apps for new pull requests automatically」と「Destroy stale review apps」にチェックを入れ、いつ環境を消すのかを選択
![](../../pic/heroku/deploy8.png)

- MRごとに環境が立ち上がるのをHeroku上で確認する
![](../../pic/heroku/deploy9.png)

- 環境に接続することも可能
![](../../pic/heroku/deploy10.png)

- CIの結果も確認できる
![](../../pic/heroku/deploy11.png)
