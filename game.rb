class Game
  attr_reader :choices, :choices, :c_choice, :p_choice_index, :c_choice_index, :p_choice
  attr_accessor :result

  def initialize(choice)
    @p_choice = choice
    @choices = ["Rock", "Paper", "Scissors"]
    @c_choice = @choices.sample
    @p_choice_index = @choices.index(p_choice)
    @c_choice_index = @choices.index(c_choice)
    @result = nil

  end

  def determine_winner
    if @p_choice == @c_choice
      @result = "Tie"
    elsif
      @p_choice_index + 1 == @c_choice_index || @p_choice_index - 2 == @c_choice_index
      @result = "Computer"
    else
      @result = "Player"
    end
  end

end
