class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ]

  attr_accessor :board

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def move(position, char = 'X')
    board[position.to_i - 1] = char
  end

  def valid_move?(position)
    return false if position.length > 1
    (position_taken?(position.to_i) || !(0...9).include?(position.to_i)) ? false : true
  end

  def position_taken?(position)
    board[position] == 'X' || board[position] == 'O' ? true : false
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    if valid_move?(input)
      move(input, current_player)
    else
      turn
    end
    display_board
  end

  def turn_count
    board.reject { |position| position == ' ' }.count
  end

  def current_player
    turn_count.even? ? 'X' : 'O'
  end

  def position_taken?(location)
    !(board[location].nil? || board[location] == " ")
  end

  def won?
    WIN_COMBINATIONS.select do |combo|
      combo.all? { |position| board[position] == 'X' } || combo.all? { |position| board[position] == 'O' }
    end.first
  end

  def full?
    board.none? { |space| space == ' ' } ? true : false
  end

  def draw?
    if won?
      false
    elsif full?
      true
    end
  end

  def over?
    won? || draw? ? true : false
  end

  def winner
    won? ? board[won?.first] : nil
  end

  def play
    until over?
      turn
    end

    if won?
      if won?.is_a? Array
        winner = board[won?.first]
        puts "Congratulations #{winner}!"
      end
    elsif draw?
      puts "Cats Game!"
    end
  end
end
