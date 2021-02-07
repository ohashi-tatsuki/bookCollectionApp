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

    # 蔵書データをCSV形式へ変換
    def to_csv( key )
        "#{key},#{@title}, #{@author}, #{@page}, #{@publish_date}¥n"
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

# BookInfoManagerクラスを定義
class BookInfoManager
    def initialize( filename )
        # CSVファイルを指定する
        @csv_fname = filename

        # 蔵書データのハッシュ
        @book_infos = {}
    end

    #データをセットアップする
    def setUp
        # CSVファイルを読み込みモードでオープンする
        open( @csv_fname, "r:UTF-8" ) { |file|
            # ファイルの行を1行ずつ取り出して、lineに読み込む
            file.each { |line|
                # 改行とカンマ区切りで分割
                key, title, author, page, pdate = line.chomp.split(',')
                # ハッシュに登録
                @book_infos[ key ] = 
                    BookInfo.new(title, author, page.to_i, Date.strptime(pdate))
            }
        }
    end

    # 蔵書データを登録する
    def addBookInfo
        # 蔵書データ1件分のインスタンスを作成
        book_info = BookInfo.new( "", "", 0, Date.new )

        #蔵書データを入力
        print "¥n"
        print "キー: "
        key = gets.chomp

        print "書籍名: "
        book_info.title = gets.chomp
        print "著者名: "
        book_info.author = gets.chomp
        print "ページ数: "
        book_info.page = gets.chomp.to_i
        print "発刊年: "
        year = gets.chomp.to_i
        print "発刊月: "
        month = gets.chomp.to_i
        print "発刊日: "
        day = gets.chomp.to_i
        book_info.publish_date = Date.new( year, month, day )

        # 入力した蔵書データをハッシュに登録する
        @book_infos[key] = book_info
    end

    # 蔵書データの一覧を表示する
    def listAllBookInfos
        puts "¥n----------"
        @book_infos.each { |key, info|
            print info.toFormattedString
        puts "¥n----------"
        }
    end

    # 蔵書データを全件ファイルへ書き込んで保存する
    def saveAllBookInfos
        # CSVファイルを書き込みモードでオープンする
        open( @csv_fname, "w:UTF-8" ) { |file|
            @book_infos.each { |key, info|
                file.print( info.to_csv( key ))
            }
            puts "¥nファイルへ保存しました"
        }
    end

    # 処理の選択と選択後の処理を繰り返す
    def run
        while true
            # 機能選択画面を表示する
            print "
            1. 蔵書データの登録
            2. 蔵書データの表示
            8. 蔵書データをファイルへ保存
            9. 終了
            番号を選んでください（1, 2, 8, 9）:
            "
            # 入力待ち
            num = gets.chomp
            case 
            when '1' == num
                # 蔵書データの登録
                addBookInfo
            when '2' == num
                # 蔵書データの表示
                listAllBookInfos
            when '8' == num
                # 蔵書データをファイルへ保存
                saveAllBookInfos    
            when '9' == num
                # アプリケーションの終了
                break;
            else
                # 処理選択待ち画面に戻る
            end
        end
    end

end

# アプリケーションのインスタンスを作る
book_info_manager = BookInfoManager.new("book_info.csv")

# BookInfoManagerの蔵書データをセットアップする
book_info_manager.setUp

# BookInfoManagerの処理の選択と選択後の処理を繰り返す
book_info_manager.run