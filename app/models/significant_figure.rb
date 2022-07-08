class SignificantFigure
  private attr_reader :number

  def initialize(number)
    @number = number
  end

  def rounded
    if number < 100
      number.floor(-1)
    else
      number.floor(-2)
    end
  end
end
