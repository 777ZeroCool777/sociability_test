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

require_relative '../lib/test.rb'

describe 'Test' do

  # Тестовый сценарий для метода show_result_pass?
  # если пользователь не отвечал на вопросы - метод возвращает nil
  it 'should do ok for show_result false' do

    # путь к questions.xml
    QUESTIONS_FILE_PATH = "#{File.dirname(__FILE__)}../../data/questions.xml"

    # путь к results.xml
    RESULTS_FILE_PATH = "#{File.dirname(__FILE__)}../../data/results.xml"

    test = Test.new(QUESTIONS_FILE_PATH, RESULTS_FILE_PATH)
    expect(test.show_result).to eq nil
  end

  # Тестовый сценарий, если пользователь отвечал на вопросы
  it 'should do ok for show_result true' do
    test = Test.new(QUESTIONS_FILE_PATH, RESULTS_FILE_PATH)

    # достаю вопросы в data/questions.xml
    test.read_questions_from_xml


    # беру результаты теста в data/results.xml
    test.read_results_from_xml

    # метод show_result должен вернуть результат
    expect(test.show_result).to eq puts test.results
  end

end