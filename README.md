# Further Efforts
プログラミングの学習時間を投稿し、みんなとシェアしあうことでモチベーションを高めるSNSです。

<img width="1440" alt="参考画面1" src="https://user-images.githubusercontent.com/62496077/94263095-7fdf1300-ff6f-11ea-92f9-2b52ea708e3d.png">

<img width="1440" alt="参考画面2" src="https://user-images.githubusercontent.com/62496077/94263127-8c636b80-ff6f-11ea-899a-d2ee53a7f53b.png">

## 開発動機
私は、人として最も素敵な瞬間はできなかったことができるようになり成長を実感する時だと思います。私自身も過去できなかったことが圧倒的な努力で結果をだし、人から認められた瞬間を経験したことがあり、その経験からもこの考えは私が努力をする原動力として根付いています。多くの人が自らの意思で努力を積み重ねていくサポートができたらと思い、当アプリの開発に至りました。

## 本番環境
https://www.furtherefforts.com  
ページ下部の簡単ログインをご利用して頂ければゲストユーザーとしてログインできます。  
※新規登録ができないエラーが発生しているため現在修正中です。ゲストログインは可能です。  

↓新規登録の場合はお手数ですが、herokuの本番環境をご利用ください↓  
https://furtherefforts.herokuapp.com/


## 使用技術
* Ruby 2.7.1 
* Ruby on Rails 6.0.3
* Mysql
* SCSS
* Rspec
* Rubocop
* Bootstrap

## インフラ
* Docker,Docker-compose
* AWS(VPC,EC2,RDS,Route53,S3)
* CicleCI(CI)

## 機能一覧
### ユーザー機能
* 登録・編集・ログイン(devise)
* SNS登録・ログイン機能
* 画像アップロード機能(ActiveStorage S3へ保存)
* 学習時間週間ランキング表示機能
* 学習言語ごとの詳細表示機能
* 詳細ページにタブメニュー（学習言語ごとの詳細一覧、過去の投稿一覧、フォロー一覧、フォロアー一覧）
### 投稿機能
* 編集、削除機能
* いいね機能 (非同期通信)
* 投稿へのコメント機能
* コメント削除機能
### 検索機能(ransack)
* 検索機能（プログラミング言語ごとに選択検索）
* 投稿検索（ユーザー名、コメント文から部分一致検索）
### その他
* ページネーション機能(kaminari)

## AWS構成図
![AWS-diagram](https://user-images.githubusercontent.com/62496077/94250775-a0ea3880-ff5c-11ea-8f8c-55c8f3c65959.png)

## 今後の進展
* VScode拡張機能でエディターを開いている間を時間計測し、当アプリに自動保存される機能を開発する
* 学習時間の進捗具合で達成度が表示されるカレンダーを実装
* ユーザー自身で管理できるTODOリスト機能を実装