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


## users table

| Column             | Type   | Options                  |
|--------------------|--------|--------------------------|
| nickname           | string | null: false              |
| email              | string | null: false, unique:true |
| encrypted_password | string | null: false              |
| last_name          | string | null: false              |
| first_name         | string | null: false              |
| last_name_kana     | string | null: false              |
| first_name_kana    | string | null: false              |
| birthday           | date   | null: false              |

### Association

- has_many :items
- has_many :purchases


## items table

| Column                | Type       | Options                        |
|-----------------------|------------|--------------------------------|
| name                  | string     | null: false                    |
| explain               | text       | null: false                    | 
| category_id           | integer    | null: false                    |
| status_id             | integer    | null: false                    |
| shipping_fee_id       | integer    | null: false                    |
| scheduled_delivery_id | integer    | null: false                    |
| prefecture_id         | integer    | null: false                    |
| price                 | integer    | null: false                    |
| user                  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase


## purchases table

| Column           | Type       | Options                        |
|------------------|------------|--------------------------------|
| item             | references | null: false, foreign_key: true |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :address


## addresses table

| Column        | Type          | Options                        |
|---------------|---------------|--------------------------------|
| post_code     | string        | null: false                    |
| prefecture_id | integer       | null: false                    |
| city          | string        | null: false                    |
| address       | string        | null: false                    |
| building_name | string        |                                |
| phone         | string        | null: false                    |
| purchase      | references    | null: false, foreign_key:true  |

### Association

- belongs_to :purchase