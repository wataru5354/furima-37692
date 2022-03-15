# README

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

# テーブル設計


## Users_Table

| Column          | Type   | Options     |
|-----------------|--------|-------------|
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| last_name       | string | null: false |
| first_name      | string | null: false |
| last_name_kana  | string | null: false |
| first_name_kana | string | null: false |
| birthday        | string | null: false |

### Association

- has_many :items
- has_many :purchases


## Items_Table

| Column             | Type       | Options                        |
|--------------------|------------|--------------------------------|
| name               | string     | null: false                    |
| explain            | text       | null: false                    | 
| category           | string     | null: false                    |
| status             | string     | null: false                    |
| shipping_fee       | string     | null: false                    |
| prefecture         | string     | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase


## Purchases_Table

| Column        | Type       | Options                        |
|---------------|------------|--------------------------------|
| post_code     | integer    | null: false                    |
| prefecture    | string     | null: false                    |
| city          | string     | null: false                    |
| address_line1 | string     | null: false                    |
| address_line2 | string     | null: false                    |
| phone         | integer    | null: false                    |
| item          | references | null: false, foreign_key: true |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user