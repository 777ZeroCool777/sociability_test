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

require_relative 'test.rb'

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

# вывожу вопросы
test.show_questions

# вывожу резульат
test.show_result