# encoding: utf-8
# Тест на общительность
# взят с http://old.syntone.ru/library/psytests/content/4969.html
# Этот код необходим при использовании русских букв на Windows
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
###

require 'rexml/document' # подключаю какой-то парсер
require_relative 'voprosu.rb'

# Передаю квесты в парсер
current_path = File.dirname(__FILE__)

file_name = current_path + '/data/questions.xml'

unless File.exist?(file_name)
  abort "Файл questions.xml не найден :("
end

file_questions = File.new(file_name, "r:utf-8")
doc_questions_xml = REXML::Document.new(file_questions)
file_questions.close

# передаю результаты в парсер
file_name = current_path + '/data/results.xml'

unless File.exist?(file_name)
  abort "Файл result.xml не найден"
end

file_results = File.new(file_name, "r:utf-8")
doc_results_xml = REXML::Document.new(file_results)
file_results.close

name = ARGV[0]

# здороваюсь с пользователем
if name
  puts "Привет, #{name}"
else
  puts "Привет, Таинственная персона"
end

puts "\nТест на общительность"
puts "\nОтветьте на вопросы"

mark = 0 # кол-во баллов


# Вывожу вопросы
doc_questions_xml.elements.each('/questions/question') do |elem|
  puts elem.text
  voprosu
  choice = STDIN.gets.chomp.downcase until choice == "а" || choice == "б" || choice == "в"

  if choice == "а"
    mark += 2
  elsif choice == "в"
    mark += 1
  end
end


# создаю нужную мне переменную для дальнейшей операции
if mark >= 30 && mark <= 32
  kol_vo = 'result_30-32'
elsif mark >= 25 && mark <= 29
  kol_vo = 'result_25-29'
elsif mark >= 19 && mark <= 24
  kol_vo = 'result_19-24'
elsif mark >= 14 && mark <= 18
  kol_vo = 'result_14-18'
elsif mark >= 9 && mark <= 17
  kol_vo = 'result_9-17'
elsif mark >= 4 && mark <= 8
  kol_vo = 'result_4-8'
else
  kol_vo = 'result_less'
end

# вывожу результат теста
doc_results_xml.elements.each("/results/#{kol_vo}") do |elem|
  puts elem.text
end