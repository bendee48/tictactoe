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

  def initialize(name=nil, symbol=nil)
    @symbol = symbol
    @name = name
  end

  attr_accessor :name, :symbol

  def make_move(choice, board)
    board.update_board(choice, self.symbol)
  end

end

class Game

  @@moves = []

  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @board = Board.new
  end

  def player_setup
    puts "Hello. Player 1 please enter your name:"
    answer = gets.chomp
    @player1.name = answer
    puts "Thanks. Now for the most important question. Noughts or Crosses?"
    answer = gets.chomp
    if answer == "noughts" 
      @player1.symbol = "O"
      @player2.symbol = "X"
    else
      @player1.symbol = "X"
      @player2.symbol = "O"
    end
    puts "Now, Player 2, what would you like to be called?"
    answer = gets.chomp
    @player2.name = answer
    puts "Thanks"
    p @player1, @player2
  end

  def start_game
    player_setup
    player1_win = false
    player2_win = false

    loop do
      puts "Player 1 you're up. Make your move."
      answer = gets.chomp
      move = check_move(answer)
      @@moves << move
      @player1.make_move(move, @board)
      @board.display
      break if check_win?(@board, @player1.symbol)
      break if check_draw?(@board)
      puts "Right, player 2, let's go."
      answer = gets.chomp
      move = check_move(answer)
      @@moves << move
      @player2.make_move(move, @board)
      @board.display
      break if check_win?(@board, @player2.symbol)
      break if check_draw?(@board)
    end
  end

  def check_move(move)
    while @@moves.include?(move)
      puts "That position is already filled. Try again."
      move = gets.chomp
    end
    move
  end

  def check_win?(board, symbol)
    check_horizontal_win?(board, symbol) || 
    check_vertical_win?(board, symbol) || 
    check_diagonal_win?(board, symbol)
  end

  def check_horizontal_win?(board, symbol)
    board.return_board.any? do |row|
      row.all? { |sq| sq == symbol }
    end
  end

  def check_vertical_win?(board, symbol)
    board.return_board.transpose.any? do |row|
      row.all? { |sq| sq == symbol }
    end
  end

  def check_diagonal_win?(board, symbol)
    board = board.return_board
    check1 = board.map.with_index { |row, ind| row[ind] }
    check2 = board.reverse.map.with_index { |row, ind| row[ind] }
    [check1, check2].any? do |row|
      row.all? { |sq| sq == symbol }
    end
  end

  def check_draw?(board)    
    !board.return_board.flatten.include?("-")
  end

end

Game.new.start_game