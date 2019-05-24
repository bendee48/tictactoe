class Game
  include Textable
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
    loop do
      puts "Player #{player_number} please enter your name:"
      answer = gets.chomp.capitalize
      (puts "Come now, I need to call you something!"; redo) if answer.strip.empty?
      (puts "Your name needs to be at least 3 characters."; redo) if answer.size < 3
      player.name = answer
      puts "Thanks #{player.name}"  
      break  
    end
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
         "#{player2.name}, you're '#{player2.symbol}'."; sleepy
  end

  def start_game
    introduction(VALID_MOVES, self)
    puts "Right, let's get started."; sleepy
    player_setup("1", player1)
    player_setup("2", player2)
    choose_symbol
    puts "Let battle commence!"; sleepy
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
    tries = 0
    until validated_move
      puts "#{current_player.name} (#{current_player.symbol}) you're up. Make your move."
      move = gets.chomp.upcase
      validated_move = !move_already_taken?(move) && valid_move?(move)
      (puts "Move already taken"; tries += 1) if move_already_taken?(move) 
      (puts "Invalid move"; tries += 1) if !valid_move?(move)
      (help; tries = 0) if tries > 3
    end   
    move
  end

  def help
    puts "Press 'M' to see the move list again or 'B' to see the board? Or Press Return to try again."
    answer = gets.chomp.downcase
    if answer == "m"
      move_list
    elsif answer == "b"
      board.display
    end
  end

  def move_already_taken?(move)
    moves.include?(move)
  end

  def valid_move?(move)
    VALID_MOVES.include?(move)
  end

  def move_list
    p VALID_MOVES
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
    puts win_text.sample
    puts "You, #{player.name}, are a winner!!! #{player.symbol}'s for the win!'"
  end
  
  def draw
    puts draw_text.sample
  end

end