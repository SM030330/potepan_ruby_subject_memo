require 'readline' 
require 'csv'

# メソッド
# 新しくtextを作成
def create_textfile
  puts "ファイル名を入力してください。"
  @file_name = Readline.readline("> ", true)
  @file_name += ".csv"
end

# ファイルの入力
def input_file(input_type)
  puts "テキストを入力してください。"
  puts "入力が終了しましたら、「input exit」と入力してください。" 

  File.open("./lib/#{@file_name}", mode = input_type,) do |f|
    while buf = Readline.readline("> ", true)
      break if buf == "input exit"
      f.puts buf
    end
  end
end

# 既存ファイルの検索
def textfile_search
  puts "ファイル名を入力してください。"
  i = 0
  Dir.glob("*.csv", base: "./lib"){ |f|
    i+= 1
    puts "#{i} #{f}"
  }
end
# 既存ファイルのロード、表示
def textfile_read
  begin
    @file_name = Readline.readline("> ", true)
    @file_name += ".csv"
    file =  File.open("./lib/#{@file_name}", mode = "r")
  rescue Errno::ENOENT
    puts "入力されたファイルは存在しません"
    puts "もう一度入力してください"
    retry
  end
  files = IO.readlines("./lib/#{@file_name}")
  puts "----------"
  files.each{|i| puts " #{i}"}
  puts "----------"
  
end

def textfile_edit?
  puts "ファイルを編集しますか？ y/n"
  loop do
    ans = Readline.readline("> ", true)

    if ans.to_s == "y"
      input_file("a+")
      break
    elsif ans.to_s == "n"
      break
    else puts "y か　nで入力してください。"
    end
  end
end

# 実行コード
loop do 
  puts "内容を選択してください"
  puts "1 新規でメモを作成 | 2 既存のメモの確認、追記　| 3 作業の終了"

  ct_no = Readline.readline("> ", true)
  puts ct_no

  if ct_no.to_i == 1
    create_textfile()   
    
    input_file("w+")
  elsif ct_no.to_i == 2
    textfile_search()
    textfile_read()
    textfile_edit?
  elsif ct_no.to_i == 3
    break
  else
    puts "作業No.の入力をおねがいします。"
    puts "作業が終了しましたら、3で終了。"
  end
end