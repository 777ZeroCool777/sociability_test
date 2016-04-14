require 'rexml/document' # подключаю какой-то парсер

class Test

  # путь к questions.xml
  QUESTIONS_FILE_PATH = "#{File.dirname(__FILE__)}/data/questions.xml"

  # путь к results.xml
  RESULTS_FILE_PATH = "#{File.dirname(__FILE__)}/data/results.xml"

  def initialize
    @mark = nil
    @question = [] # массив с вопросами
    @result = [] # массив с результатом
  end

  # метод выводит варианты ответов на экран
  def ask_answers
    puts "    а) да;

    б) нет;

    в) иногда."
  end

  # метод сохраняет массив вопросов в @questions
  def read_questions_from_xml


    abort "Файл questions.xml не найден :(" unless File.exist?(QUESTIONS_FILE_PATH)

    file_questions = File.new(QUESTIONS_FILE_PATH, "r:utf-8")
    doc_questions_xml = REXML::Document.new(file_questions)
    file_questions.close

    # Вывожу вопросы
    doc_questions_xml.elements.each('/questions/question') do |elem|
      @question << elem.text
    end
  end

  # метод записывает результат теста в @result
  def read_results_from_xml

    # передаю результаты в парсер

    abort "Файл result.xml не найден" unless File.exist?(RESULTS_FILE_PATH)


    file_results = File.new(RESULTS_FILE_PATH, "r:utf-8")
    doc_results_xml = REXML::Document.new(file_results)
    file_results.close

    # создаю нужную мне переменную для дальнейшей операции
    case @mark
      when (30..32) then kol_vo = 'result_30-32'
      when (25..29) then kol_vo = 'result_25-29'
      when (19..24) then kol_vo = 'result_19-24'
      when (14..18) then kol_vo = 'result_14-18'
      when (9..17) then kol_vo = 'result_9-17'
      when (4..8) then kol_vo = 'result_4-8'
      else
        kol_vo = 'result_less'
    end


    doc_results_xml.elements.each("/results/#{kol_vo}") do |elem|
      @result << elem.text
    end
  end

  # метод подсчитывает кол-во баллов
  def mark_calculator(choice_answer)
    if choice_answer == "а"
      @mark += 2
    elsif choice_answer == "в"
      @mark += 1
    end

  end

  # метод выводит вопросы на экран
  def ask_questions

    @mark = 0 # инсцилизирую баллы

    @question.each do |elem|
      puts elem
      ask_answers

      choice_answers = STDIN.gets.chomp.downcase until choice_answers == "а" ||
          choice_answers == "б" || choice_answers == "в"

      mark_calculator(choice_answers)
    end
  end

  # метод выводит результат теста на экран
  def show_result_pass?
    puts @result unless @question.empty?
  end
end