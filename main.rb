require 'date'

# 蔵書データクラス
class BookInfo
    #アクセサー
    attr_accessor :title, :author, :page, :publish_date

    # インスタンス初期化
    def initialize( title, author, page, publish_date )
        @title = title
        @author = author
        @page = page
        @publish_date = publish_date
    end

    # 蔵書データのインスタンス文字列を返す
    def to_s
        "#{@title}, #{@author}, #{@page}, #{@publish_date}"
    end

    # 書式をつけて出力する操作を追加
    # 項目の区切りを文字を引数に指定することができる
    # 引数を省略した場合は改行を区切り文字にする
    def toFormattedString( sep = "¥n" )
        "書籍名: #{@title}#{sep}著者名: #{@author}#{sep}ページ数: #{@page}ページ#{sep}発刊日: #{@publish_date}#{sep}"
    end
end

# 複数冊の蔵書データを登録する
book_infos = Hash.new
book_infos["Urashima2020"] = BookInfo.new(
    "亀を引き寄せる法則",
    "浦島 太郎",
    248,
    Date.new(2020, 1, 25)     
)
book_infos["Momo2020"] = BookInfo.new(
    "僕が桃から生まれた理由",
    "桃 太郎",
    316,
    Date.new(2020, 5, 5)     
)

# 登録したデータを文字列表現で1冊ずつ出力する
# valueがクラスのインスタンスになっていることに注意
book_infos.each { |key, value|
    puts "#{key}: #{value.to_s}"
}

# 変数book_infoで参照できようにする
# インスタンスをいったん保持してからアクセスすると楽
book_info = book_infos[ "Urashima2020" ]
puts book_info.title
puts book_info.author
puts book_info.page
puts book_info.publish_date