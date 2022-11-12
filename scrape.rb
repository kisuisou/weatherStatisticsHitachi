require 'mechanize'
require 'csv'

URL='https://www.data.jma.go.jp/obd/stats/etrn/view/monthly_a1.php?prec_no=40&block_no=1011'
agent=Mechanize.new

CSV.open('max_temp_Jan.csv','w') do |f|
  for year in 1981..2020 do
    page=agent.get("#{URL}&year=#{year}")
    max_temp=page.search('table#tablefix1 tr')[3].children[8].inner_text.match(/[0-9.]+/)
    puts "#{year}:#{max_temp}C"
    f << [year,max_temp]
  end
end
