require 'test/unit'
require './tictactoe'

class TicTacToeTest < Test::Unit::TestCase
  @@board = Board.new
  @@player = Player.new("Mr Smith", "O")

  def test_board
    @@board.update_board("TM", "O")
    @@board.update_board("BR", "X")
    assert_equal(@@board.top_row, ["-", "O", "-"])
    assert_equal(@@board.bottom_row, ["-", "-", "X"])
  end

  def test_move
    @@player.make_move("MM", @@board)
    assert_equal(@@board.middle_row, ["-", "O", "-"])
  end

  def test_check_horizontal_win
    board = Board.new
    game = Game.new
    moves = ["TL", "TM", "TR"]
    moves.each {|move| board.update_board(move, "O")}
    assert_equal(game.check_horizontal_win?(board, "O"), true)
  end

  def test_check_horizontal_win_fail
    board = Board.new
    game = Game.new
    moves = ["TL", "MM", "TR"]
    moves.each {|move| board.update_board(move, "O")}
    assert_equal(game.check_horizontal_win?(board, "O"), false)
  end

  def test_check_vertical_win
    board = Board.new
    game = Game.new
    moves = ["TL", "ML", "BL"]
    moves.each {|move| board.update_board(move, "X")}
    assert_equal(game.check_vertical_win?(board, "X"), true)
  end

end
