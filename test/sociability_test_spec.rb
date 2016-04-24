# Этот код необходим при использовании русских букв на Windows
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end
###

require 'rspec'

require_relative '../test.rb'

describe 'Test' do

  # Тестовый сценарий для метода show_result
  # если пользователь не отвечал на вопросы - метод возвращает nil
  it 'should do ok for show_result false' do
    test = Test.new
    expect(test.show_result).to eq nil
  end

  # Тестовый сценарий, если пользователь отвечал на вопросы
  it 'should do ok for show_result true' do
    test = Test.new

    # достаю вопросы в lib/questions.xml
    test.read_questions_from_xml


    # беру результаты теста в lib/results.xml
    test.read_results_from_xml

    # метод show_result должен вернуть результат
    expect(test.show_result).to eq puts test.results
  end

end