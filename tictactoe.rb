class Board
  @@columns = { L: 0, M: 1, R: 2 }

  def initialize
    @top_row = ["-", "-", "-"]
    @middle_row = ["-", "-", "-"]
    @bottom_row = ["-", "-", "-"]
  end

  #test
  attr_reader :top_row, :bottom_row, :middle_row

  def update_board(move, player_symbol)
    row, column = move.chars
    case row
    when "T"
      @top_row[@@columns[column.to_sym]] = player_symbol
    when "M"
      @middle_row[@@columns[column.to_sym]] = player_symbol
    when "B"
      @bottom_row[@@columns[column.to_sym]] = player_symbol
    end
  end

  def display
    puts @top_row.join("|"), @middle_row.join("|"), @bottom_row.join("|")
  end

  def return_board
    [@top_row, @middle_row, @bottom_row]
  end

end

class Player

  def initialize(name, symbol)
    @symbol = symbol
    @name = name
  end

  def make_move(choice, board)
    board.update_board(choice, @symbol)
  end

end

class Game

  def check_win?(board, symbol)

  end

  def check_horizontal_win?(board, symbol)
    board.return_board.any? do |row|
      row.all? { |sq| sq == symbol }
    end
  end

  def check_vertical_win?(board, symbol)
    
  end

end

Game.new.check_vertical_win?(Board.new, "X")
