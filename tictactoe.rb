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

  def symbol_to_name(symbol)
    converter = {X: "Crosses", O: "Noughts" }
    converter[symbol.to_sym]
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

  def player_setup
    puts "Player 1 please enter your name:"
    answer = gets.chomp.capitalize
    player1.name = answer
    puts "Thanks #{player1.name}. Now for the most important question. Noughts or Crosses?"
    loop do
      answer = gets.chomp.downcase
      if answer =~  /\An[ou]\w+[ts]\z/i
        player1.symbol = "O"
        player2.symbol = "X"
        puts "Great, you chose Noughts."
        break
      elsif answer =~ /\Acro+s+e?s+\z/i
        player1.symbol = "X"
        player2.symbol = "O"
        puts "You chose Crosses."
        break
      else
        puts "Sorry I'm not sure what that is."
        puts "Please type 'noughts' or 'crosses'."
      end
    end
    puts "Now, Player 2, what would you like to be called?"
    answer = gets.chomp.capitalize
    player2.name = answer
    puts "Fair enough. #{player2.name} it is."
    puts "#{player1.name} chose #{player1.symbol_to_name(player1.symbol)}. "\
         "So that makes you #{player2.symbol_to_name(player2.symbol)}."
  end

  def start_game
    player_setup
    puts "Right. Let battle commence."
    player1_win = false
    player2_win = false

    loop do
      puts "#{@player1.name} you're up. Make your move."
      answer = gets.chomp.upcase
      move = check_move_exists(answer)
      # move = check_wrong_move(move)
      @moves << move
      @player1.make_move(move, @board)
      @board.display
      break if check_win?(@board, @player1.symbol)
      break if check_draw?(@board)
      puts "Right, #{@player2.name}, let's go."
      answer = gets.chomp.upcase
      move = check_move_exists(answer)
      # move = check_wrong_move(move)
      @moves << move
      @player2.make_move(move, @board)
      @board.display
      break if check_win?(@board, @player2.symbol)
      break if check_draw?(@board)
    end
  end

  def check_move_exists(move)
    while @moves.include?(move)
      puts "That position is already filled. Try again."
      move = gets.chomp.upcase
    end
    move.upcase
  end

  # def check_wrong_move(move)
  #    until move =~ /\At[lmr]\z|\Am[lmr]\z|\Ab[lmr]\z/i
  #     puts "Hmm, I'm not sure what that move is."
  #     move = gets.chomp
  #    end
  #    move.upcase 
  # end

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

end

Game.new.start_game