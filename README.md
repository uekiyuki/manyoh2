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
|lavel_name|string|

#### heroku デプロイ手順
|:--:|
|$ rails assets:precompile RAILS_ENV=production|
|$ git add -A|
|$ git commit -m "init"|
|$ heroku create|
|$ git push heroku master|
|$ heroku run rails db:migrate|
