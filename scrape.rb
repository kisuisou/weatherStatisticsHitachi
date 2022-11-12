require 'mechanize'
require 'csv'

URL='https://www.data.jma.go.jp/obd/stats/etrn/view/monthly_a1.php?prec_no=40&block_no=1011'
agent=Mechanize.new
targets=['最高','最低','平均']
print "開始年->"
start = gets.to_i
print "取得年数->"
length=gets.to_i
finish = start+length-1
print "取得月->"
month = gets.to_i
print "最高気温:0 or 最低気温:1 or 平均気温:2->"
target = gets.to_i
file_name = "#{month}月の#{targets[target]}気温(#{length}年分).csv"
td_index= target==2 ? 5 : 8+target
CSV.open(file_name,'w') do |f|
  for year in start..finish do
    page=agent.get("#{URL}&year=#{year}")
    temp=page.search('table#tablefix1 tr')[2+month].children[td_index].inner_text.match(/[0-9.-]+/)
    puts "#{year}:#{temp}℃"
    f << [year,temp]
  end
end
