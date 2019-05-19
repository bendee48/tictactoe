require 'test/unit'
require './tictactoe'

class TicTacToeTest < Test::Unit::TestCase

  def test_board
    board = Board.new
    player = Player.new("Mr Smith", "O")
    board.update_board("TM", "O")
    board.update_board("BR", "X")
    assert_equal(board.top_row, ["-", "O", "-"])
    assert_equal(board.bottom_row, ["-", "-", "X"])
  end

  def test_board_update
    board = Board.new
    board.update_board("TR", "X")
    assert_equal(board.top_row, ["-", "-", "X"])
  end

  def test_move
    board = Board.new
    player = Player.new("Ben", "O")
    player.make_move("MM", board)
    assert_equal(board.middle_row, ["-", "O", "-"])
  end

  def test_horizontal_win
    board = Board.new
    game = Game.new
    moves = ["TL", "TM", "TR"]
    moves.each {|move| board.update_board(move, "O")}
    assert_equal(game.check_horizontal_win?(board, "O"), true)
  end

  def test_non_horizontal_win
    board = Board.new
    game = Game.new
    moves = ["TL", "MM", "TR"]
    moves.each {|move| board.update_board(move, "O")}
    assert_equal(game.check_horizontal_win?(board, "O"), false)
  end

  def test_vertical_win
    board = Board.new
    game = Game.new
    moves = ["TR", "MR", "BR"]
    moves.each {|move| board.update_board(move, "X")}
    assert_equal(game.check_vertical_win?(board, "X"), true)
  end

  def test_non_vertical_win
    board = Board.new
    game = Game.new
    moves = ["TL", "MM", "BL"]
    moves.each {|move| board.update_board(move, "X")}
    assert_equal(game.check_vertical_win?(board, "X"), false)
  end

  def test_diagonal_win
    board = Board.new
    game = Game.new
    moves = ["TR", "MM", "BL"]
    moves.each {|move| board.update_board(move, "O")}
    assert_equal(game.check_diagonal_win?(board, "O"), true)
  end

  def test_non_diagonal_win
    board = Board.new
    game = Game.new
    moves = ["TR", "MM", "BM"]
    moves.each {|move| board.update_board(move, "O")}
    assert_equal(game.check_diagonal_win?(board, "O"), false)
  end

  def test_win 
    board = Board.new
    game = Game.new
    o_moves = ["TR", "TL"]
    x_moves = ["TM", "MM", "BM"]
    o_moves.each {|move| board.update_board(move, "O")}
    x_moves.each {|move| board.update_board(move, "X")}
    assert_equal(game.check_win?(board, "X"), true)
  end

  def test_non_win 
    board = Board.new
    game = Game.new
    o_moves = ["TR", "TL", "MM"]
    x_moves = ["TM", "MR", "BM"]
    o_moves.each {|move| board.update_board(move, "O")}
    x_moves.each {|move| board.update_board(move, "X")}
    assert_equal(game.check_win?(board, "X"), false)
  end

end
