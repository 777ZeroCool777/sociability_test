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

require_relative 'lib/test.rb'

name = ARGV[0]

# здороваюсь с пользователем
if name
  puts "Привет, #{name}"
else
  puts "Привет, Таинственная персона"
end

puts "\nТест на общительность"
puts "\nОтветьте на вопросы"

# создаю экземпляр теста
test = Test.new

# беру вопросы с questions.xml
test.read_questions_from_xml

# вывожу вопросы
test.ask_questions

# беру результат теста с results.xml
test.read_results_from_xml

# вывожу результат
test.show_result