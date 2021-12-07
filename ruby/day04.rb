module Day04
  class Board
    def initialize(board_array)
      @rows = board_array
      @marks = [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0]
      ]
      @nums_played = []
    end

    def play_num(num)
      @nums_played << num
      @rows.each_with_index { |row, row_idx|
        row.each_with_index { |n, col_idx|
          if n == num
            @marks[row_idx][col_idx] = 1
            @rows[row_idx][col_idx] = 0
          end
        }
      }
    end

    def has_won?
      sum5 = Proc.new { |row| row.inject(:+) == 5 }
      @marks.any? sum5 or @marks.transpose.map(&:reverse).any? sum5
    end

    def score
      board_sum = @rows.reduce(0) { |sum, row| row.reduce(sum) { |sum, num| sum += num } }
      board_sum * @nums_played.last
    end

  end
end

#
# Entrypoint
#

$LINES = File.read('../data/day04.txt').split("\n")

$NUMS = $LINES.first.split(',').collect { |num_string| num_string.to_i }
raw_boards = $LINES.drop(2)
sep = raw_boards[5]
$BOARDS = raw_boards.slice_after(sep)
  .collect { |board| board.take(5) }
  .collect { |board|
    board.collect { |row_string|
      row_string.split(' ') .collect { |num_string|
        num_string.to_i } } }
          .collect { |board_array| Day04::Board.new board_array }

$WINNERS = []
$NUMS.each do |num|

  $BOARDS.each do |board|

    unless $WINNERS.include?(board)
      board.play_num num
      if board.has_won?
        $WINNERS << board
      end
    end

  end

end

p "First Board Score: #{$WINNERS.first.score}"
p "Last Board Score: #{$WINNERS.last.score}"
