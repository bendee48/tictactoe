require './game'
require './board'
require './player.rb'
require './textable.rb'

describe 'Game' do
  let(:game) { Game.new }

  describe '#check_horizontal_win?' do
    it 'wins if a horizontal row is filled with the same symbol' do
      ['TL', 'TM', 'TR'].each { |move| game.board.update_board(move, 'X')}
      expect(game.check_win?(game.board, 'X')).to be true
    end
  end

  describe '#check_vertical_win?' do
    it 'wins if a vertical row is filled with the same symbol' do
      ['TL', 'ML', 'BL'].each { |move| game.board.update_board(move, 'O')}
      expect(game.check_win?(game.board, 'O')).to be true
    end
  end

  describe '#check_diagonal_win?' do
    it 'wins if a diagonal row is filled with the same symbol' do
      ['TL', 'MM', 'BR'].each { |move| game.board.update_board(move, 'X')}
      expect(game.check_win?(game.board, 'X')).to be true
    end
  end

  describe '#valid_move?' do
    it 'catches non-valid moves' do
      expect(game.valid_move?('BX')).to be false
    end

    it 'validates valid moves' do
      expect(game.valid_move?('MM')).to be true
    end
  end

  describe '#move_already_taken?' do
    let(:moves) { game.moves << 'TL' << 'MM'}

    it 'lets the player know a move is already taken' do
      moves
      expect(game.move_already_taken?('TL')).to be true
    end

    it "doesn't flag a move not already made" do
      moves
      expect(game.move_already_taken?('BL')).to be false
    end
  end

end

describe 'Player' do
  it '#make_move updates the game board' do
    player = Player.new("Smith", "O")
    board = Board.new
    player.make_move("TL", board)
    expect(board.return_board).to eql [['O', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
  end
end