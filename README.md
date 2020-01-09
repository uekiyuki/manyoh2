#### Userモデル
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|name|string|
|e-mail|string|
|password_digest|string|
|age|string|
|sex|string|
#### Taskモデル
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|user_id(FK)|references|
|title|string|
|content|text|
|time_limit|date|
|priority|string|
|status|string|
#### labelingモデル
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|task_id(FK)|references|
|label_id(FK)|references|
#### Labelモデル
|カラム名|データ型|
|:--:|:--:|
|id|integer|
|name|string|

#### heroku デプロイ手順
|手順|コマンド|
|:--:|:--:|
|1|$ rails assets:precompile RAILS_ENV=production|
|2|$ git add -A|
|3|$ git commit -m "init"|
|4|$ heroku create|
|5|$ git push heroku master|
|6|$ heroku run rails db:migrate|
