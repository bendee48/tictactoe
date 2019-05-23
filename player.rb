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