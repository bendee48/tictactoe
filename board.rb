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
    puts "\n", top_row.join("|"), middle_row.join("|"), bottom_row.join("|"), "\n"
  end

  def return_board
    [top_row, middle_row, bottom_row]
  end

end