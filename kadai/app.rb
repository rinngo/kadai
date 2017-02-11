#coding: utf-8
Encoding.default_external='utf-8'
# ライブラリのロード
require 'sequel'
require 'sinatra'

# DBへの接続
db_path = File.dirname(__FILE__) + "/keijiban.db"
DB = Sequel.sqlite(db_path)

#DB内にcommentsテーブルがあるか判断
if !(DB.table_exists?(:comments)) then
  #テーブルがない場合作成
  DB.create_table :comments do
    primary_key :id
    String :name
    String :comment
  end
end

class Comments<Sequel::Model
end

#掲示板の内容表示
get '/' do
  @comments=Comments.all
  erb :layoutt
end

#コメントの追加・表示
post '/' do
  Comments.insert(:name=>params[:name],:comment=>params[:comment])
  @comments=Comments.all
  erb :layoutt
end
