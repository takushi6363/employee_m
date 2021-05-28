# README

# 社員情報管理アプリケーション

# 社員情報管理アプリケーション概要
社員情報の情報を管理するアプリケーションです。
社員情報の管理、図書費使用状況の管理、有給休暇の管理がで出来ます。
事務が社員の情報を管理する為に作成したアプリケーションです。

# URL

# テスト用アカウント

# 利用方法

# 目指した課題解決
  当社は上記管理情報をエクセルデータにてそれぞれに管理していた為、
  上記を一括で纏めたアプリケーションを作成できないかと思い作成しました。
  また事務もテレワーク体制となり、上記データが会社のパソコンで管理
  している為、自宅でも確認、追記できるようアプリケーションにしました。

# 洗い出した要件
  社員情報の登録・編集
  社員情報の一覧表示
  社員の図書費使用状況一覧
  社員の図書費使用状況の詳細
  社員の図書費の登録
  社員の図書費の過去の使用状況の検索
  社員の有給休暇の状況一覧
  社員の有給休暇の取得情報の詳細
  社員の有給休暇の取得情報の過去データの検索
  上記管理情報の一括表示

# テーブル設計

## users テーブル


| Column                  | Type    | Options                  |
| ------------------------| ------- | ------------------------ |
| name                    | string  | null: false              |
| address                 | string  |                          |
| birthday                | date    |                          |
| phone_number            | string  |                          |
| phone_number_2          | string  |                          |
| joining_day             | date    | null: false              |
| working_days_id         | integer | null: false              |

### Association

- has_many :books
- has_many :vacations


## books テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| price                  | integer    | null: false                    |
| purchase_date          | date       | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association
- belongs_to :user


## vacations テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| day                    | float      | null: false                    |
| paid_vacation_day      | date       | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association
- belongs_to :user


