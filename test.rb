require 'rexml/document' # подключаю какой-то парсер

class Test

  def initialize
    @mark = nil
  end

  # метод выводит варианты ответов на экран
  def show_answers
    puts "    а) да;

    б) нет;

    в) иногда."
  end

  # метод выводит вопросы на экран
  def show_questions

    @mark = 0 # инцилизирую баллы

    # Передаю квесты в парсер
    current_path = File.dirname(__FILE__)

    file_name = current_path + '/data/questions.xml'

    unless File.exist?(file_name)
      abort "Файл questions.xml не найден :("
    end

    file_questions = File.new(file_name, "r:utf-8")
    doc_questions_xml = REXML::Document.new(file_questions)
    file_questions.close

    # Вывожу вопросы
    doc_questions_xml.elements.each('/questions/question') do |elem|
      puts elem.text
      show_answers
      choice = STDIN.gets.chomp.downcase until choice == "а" || choice == "б" || choice == "в"

      if choice == "а"
        @mark += 2
      elsif choice == "в"
        @mark += 1
      end
    end
  end

  # метод выводит результат теста
  def show_result

    # передаю результаты в парсер
    current_path = File.dirname(__FILE__)

    file_name = current_path + '/data/results.xml'

    unless File.exist?(file_name)
      abort "Файл result.xml не найден"
    end

    file_results = File.new(file_name, "r:utf-8")
    doc_results_xml = REXML::Document.new(file_results)
    file_results.close

    # создаю нужную мне переменную для дальнейшей операции
    if @mark >= 30 && @mark <= 32
      kol_vo = 'result_30-32'
    elsif @mark >= 25 && @mark <= 29
      kol_vo = 'result_25-29'
    elsif @mark >= 19 && @mark <= 24
      kol_vo = 'result_19-24'
    elsif @mark >= 14 && @mark <= 18
      kol_vo = 'result_14-18'
    elsif @mark >= 9 && @mark <= 17
      kol_vo = 'result_9-17'
    elsif @mark >= 4 && @mark <= 8
      kol_vo = 'result_4-8'
    else
      kol_vo = 'result_less'
    end

    # вывожу результат теста
    doc_results_xml.elements.each("/results/#{kol_vo}") do |elem|
      puts elem.text
    end
  end
end