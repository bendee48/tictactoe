module Textable

  def introduction(valid_moves, game)
    puts "Welcome to TictacToe."
    puts "The whirlwind extravaganza of...trying to put 3 things in a row"
    puts "If you would like to see how to play, press 'R' or press Return to continue."
    answer = gets.chomp.downcase
    rules(valid_moves, game) if answer == "r"
  end


  def rules(valid_moves, game)
    puts "Players take it in turns to place either a cross or a nought on the board."
    puts "Try to get 3 in a row to win."
    puts "The board is split into 3 rows of top, middle and bottom."
    puts "...and 3 columns of left, middle and right."
    puts "Use the first letter's of a row and column to make your move eg. TL (Top Left)"
    puts "Press 'M' to see the full move list, or press Return to continue."
    answer = gets.chomp.downcase
    game.move_list if answer == "m"
  end

  def win_text
    ["Today is the day you'll recount to your grandchildren a thousand times.",
      "Rejoice. Victory is yours!", "Few have achieved more in their lifetime.",
      "I'm in tears...sorry, I said I wouldn't do this but...", 
      "Congratulations!", "Well done, feel free to celebrate long into the night.",
      "I knew there was something special about you."
    ]
  end

  def draw_text
    ["What can I say, you've wasted all our time.", "You're both equally good...or equally bad.",
     "The king of all the results; the draw. Well done.", "It's a draw, hmm, I guess, try again?",
     "Well that's 5 minutes of my life I'll never get back.", "All hail the draw and all who sail in her.",
     "You should both be ashamed of yourselves."
    ]
  end

end