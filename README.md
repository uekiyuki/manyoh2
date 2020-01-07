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


