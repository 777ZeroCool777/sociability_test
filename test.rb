require 'rexml/document' # подключаю какой-то парсер

class Test

  attr_reader :results

  # путь к questions.xml
  QUESTIONS_FILE_PATH = "#{File.dirname(__FILE__)}/lib/questions.xml"

  # путь к results.xml
  RESULTS_FILE_PATH = "#{File.dirname(__FILE__)}/lib/results.xml"

  def initialize
    @mark = nil
    @questions = [] # массив с вопросами
    @results = [] # массив с результатом
  end

  def ask_answers
    puts "    а) да;\n" \
         "    б) нет;\n" \
         "    в) иногда."
  end

  # метод сохраняет массив вопросов в @questions
  def read_questions_from_xml

    begin
    file_questions = File.open(QUESTIONS_FILE_PATH, "r:utf-8")
    rescue Errno::ENOENT => e
      puts "Файл questions.xml не был найден :("
      abort e.message
    end

    doc_questions_xml = REXML::Document.new(file_questions)
    file_questions.close

    # Вывожу вопросы
    doc_questions_xml.elements.each('/questions/question') do |elem|
      @questions << elem.text
    end
  end

  # метод записывает результат теста в @result
  def read_results_from_xml

    # передаю результаты в парсер
    begin
    file_results = File.open(RESULTS_FILE_PATH, "r:utf-8")
    rescue Errno::ENOENT => e
      puts "Файл results.xml не был найден :("
      abort e.message
    end

    doc_results_xml = REXML::Document.new(file_results)
    file_results.close

    # создаю нужную мне переменную для дальнейшей операции
    case @mark
      when (30..32) then kol_vo = 'result_30-32'
      when (25..29) then kol_vo = 'result_25-29'
      when (19..24) then kol_vo = 'result_19-24'
      when (14..18) then kol_vo = 'result_14-18'
      when (9..13) then kol_vo = 'result_9-13'
      when (4..8) then kol_vo = 'result_4-8'
      else
        kol_vo = 'result_less'
    end


    doc_results_xml.elements.each("/results/#{kol_vo}") do |elem|
      @results << elem.text
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

  def ask_questions

    @mark = 0 # инициализирую баллы

    @questions.each do |elem|
      puts elem
      ask_answers

      choice_answers = STDIN.gets.chomp.downcase until choice_answers == "а" ||
          choice_answers == "б" || choice_answers == "в"

      mark_calculator(choice_answers)
    end
  end

  def show_result
    puts @results unless @questions.empty?
  end
end