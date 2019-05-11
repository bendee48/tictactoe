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

end