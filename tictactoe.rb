class Board
  attr_reader :top_row, :bottom_row, :middle_row, :columns

  def initialize
    @top_row = ["-", "-", "-"]
    @middle_row = ["-", "-", "-"]
    @bottom_row = ["-", "-", "-"]
    @columns = { L: 0, M: 1, R: 2 }
  end

  def update_board(move, player_symbol)
    row, column = move.chars
    case row
    when "T"
      top_row[columns[column.to_sym]] = player_symbol
    when "M"
      middle_row[columns[column.to_sym]] = player_symbol
    when "B"
      bottom_row[columns[column.to_sym]] = player_symbol
    end
  end

  def display
    puts top_row.join("|"), middle_row.join("|"), bottom_row.join("|")
  end

  def return_board
    [top_row, middle_row, bottom_row]
  end

end

class Player
  attr_accessor :name, :symbol

  def initialize(name=nil, symbol=nil)
    @symbol = symbol
    @name = name
  end

  def make_move(choice, board)
    board.update_board(choice, self.symbol)
  end

end

class Game
  attr_reader :player1, :player2, :board, :moves

  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @board = Board.new
    @moves = []
  end

  VALID_MOVES = %w(TL TM TR ML MM MR BL BM BR)
  VALID_SYMBOLS = {"O" => "Noughts", "X" => "Crosses"}

  def player_setup(player_number, player)
    puts "Player #{player_number} please enter your name:"
    answer = gets.chomp.capitalize
    player.name = answer
    puts "Thanks #{player.name}"
  end

  def choose_symbol
    puts "Now #{player1.name}, time for the most important question. Noughts or Crosses? "\
         "Please type 'O' or 'X' to select:"
    loop do
      answer = gets.chomp.upcase
      valid_symbols = VALID_SYMBOLS.keys
      if valid_symbols.include?(answer)
        player1.symbol = answer
        valid_symbols.delete(answer)
        player2.symbol = valid_symbols.first
        puts "Thanks."
        break
      else
        puts "Sorry I'm not sure what that is."
        puts "Please type 'O' or 'X'."
      end
    end
    puts "Okay, #{player1.name} chose '#{player1.symbol}', which means "\
         "#{player2.name}, you're '#{player2.symbol}'."
  end

  def introduction
    puts "Welcome to TictacToe."
    puts "The whirlwind extravaganza of...trying to put 3 things in a row"
    puts "If you would like to see how to play, press 'R' or press Return to continue."
    answer = gets.chomp.downcase
    rules if answer == "r"
  end

  def rules
    puts "Players take it in turns to place either a cross or a nought on the board."
    puts "Try to get 3 in a row to win."
    puts "The board is split into 3 rows of top, middle and bottom."
    puts "...and 3 columns of left, middle and right."
    puts "Use the first letter's of a row and column to make your move eg. TL (Top Left)"
    puts "Press 'L' to see the full move list, or press Return to continue."
    answer = gets.chomp.downcase
    p VALID_MOVES if answer == "l"
  end

  def start_game
    introduction
    puts "Right, let's get started."
    player_setup("1", player1)
    player_setup("2", player2)
    choose_symbol
    puts "Let battle commence!"
    main_game_loop
  end

  def main_game_loop
    players = [player1, player2].cycle
    loop do
      current_player = players.next      
      move = validate_move(current_player)
      moves << move
      current_player.make_move(move, board)
      board.display
      if check_win?(board, current_player.symbol)
        winner_winner_chicken_dinner(current_player)
        break
      end
      if check_draw?(board)
        draw
        break
      end
    end
  end

  def validate_move(current_player) 
    validated_move = false
    until validated_move
      puts "#{current_player.name} (#{current_player.symbol}) you're up. Make your move."
      move = gets.chomp.upcase
      validated_move = !move_already_taken?(move) && valid_move?(move)
      puts "Move already taken" if move_already_taken?(move)
      puts "Invalid move" if !valid_move?(move)
    end   
    move
  end

  def move_already_taken?(move)
    moves.include?(move)
  end

  def valid_move?(move)
    VALID_MOVES.include?(move)
  end

  def move_list
    puts "This will be the MOVE LIST yeaaah!"
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

  def winner_winner_chicken_dinner(player)
    puts "Today is the day you'll recount to your grandchildren a thousand times."
    puts "You, #{player.name}, are a winner!!!"
  end

  def draw
    puts "What can I say, you've wasted all our time."
  end

end

Game.new.start_game
