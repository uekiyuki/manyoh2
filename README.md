# README
Users
| カラム名 | データ型 |
| :--- | :--- |
| id | integer |
| name | string |
| e-mail | stiring |
| password-digest | string |
| sex | string |
| age | string |

Tasks
| カラム名 | データ型 |
| :--- | :--- |
| id | integer |
| user_id(FK) | references |
| title | stiring |
| content | text |
| deadline | date |
| priority | string |
| status | string |

laberings
| カラム名 | データ型 |
| :--- | :--- |
| id | integer |
| task_id(FK) | references |
| label_id(FK) | references|

Labels
| カラム名 | データ型 |
| --- | --- |
| id | integer |
| name | string |

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
