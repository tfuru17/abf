Name tfuru17/abf
(Aggregated Batch Framework(ABF))
====

##Overview
　Oracle(PL/SQL)でのバッチプログラム開発を効率化するためのフレームワークです。
It is a framework for streamlining batch program development in Oracle (PL/SQL).


## Description
　SQL文(VIEW)の作成のみで、コーディング作業の大半を済ますことができるようになります。
　起動、ログ出力、データの移送ロジックの記述は、あらかじめ用意された設定に基づいて自動生成されます。

Most of the coding work can only be done by creating a SQL statement (VIEW).
The description of startup, log output, and data transfer logic is automatically generated based on pre-set settings.


　このフレームワークを活用するために必要なのは以下の2つだけです。
　・処理データを取得するSQL文
　・そのSQLが取得した項目と、登録先となるテーブルの項目とをマッピングしたマスタ
　ABFは、マスタの登録内容を、あらかじめ用意されたテンプレートとマージし、バッチプログラムのソースを自動生成し、実行します。

In order to make use of this framework, we need only the following two.
· SQL statements for acquiring process data
· A master that maps the items acquired by the SQL and the items of the table to be registered
ABF merges the registered content of the master with the template prepared in advance, automatically generates the source of the batch program and executes it.

## Licence
[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author [tfurukaw]
