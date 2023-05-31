class ChronosController < ApplicationController
  def index
  end

  def new
  end

  def create
    result = get_answers

    if result >= 37
      chrono = Chrono.find(1)
    elsif result < 37 && result >= 27
      chrono = Chrono.find(2)
    elsif result < 27 && result >= 17
      chrono = Chrono.find(3)
    else
      chrono = Chrono.find(4)
    end
    render "index", locals: {chrono: chrono}

    if @user
      @user.chrono_id = chrono.id
      @user.save
    end
    
  end



  private

  def get_answers
    questions = []
    i = 1

    12.times do
      questions << "q#{i}"
      i+= 1
    end

    answers = []
    questions.each do |q|
      answers << params[q]
    end
    
    calculate(answers)
  end

  def calculate(answers)

    total = 0
    answers.each do |a|
      if a == "four"
        total += 4
      elsif a == "three"
        total += 3
      elsif a == "two"
        total += 2
      elsif a == "one"
        total += 1
      end
    end
    total
  end

  def chrono_params
    params.require(:chrono).permit(:image)
  end
end