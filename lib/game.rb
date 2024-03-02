require_relative 'board'
require_relative 'knight'

class Game
    LETTER_TO_I = {
        'A' => 0,
        'B' => 1,
        'C' => 2,
        'D' => 3,
        'E' => 4,
        'F' => 5,
        'G' => 6,
        'H' => 7
    }

    def initialize
        @board = Board.new
        welcome
        play
    end

    def play
        @board.display
        ask_player('start')
        start = user_input_to_coordinates(validate_user_input(gets.chomp))
        ask_player('destination')
        destination = user_input_to_coordinates(validate_user_input(gets.chomp))
        
        knight = Knight.new(start, destination)

        path = knight.knight_moves

        path.each do |pos|
            @board.add_mark_to_board(pos, 'blue')
        end

        @board.add_mark_to_board(start, 'magenta')
        @board.add_mark_to_board(destination, 'magenta')

        @board.display

        puts "Your knight made it in #{knight.path.length - 1} moves!"

        initialize if start_again?
    end

    def welcome
        puts 'Welcome to Knights Travails!'
        puts 'We will find the shortest path from the starting point you set to the destination you set.'
        puts "Your input should have a structute like this: A5, b6, h-8.\n"
    end

    def ask_player(coordinates = '')
        question = coordinates == 'start' ? "Choose the starting position of the knight.\n" : "Choose the destination of the knight.\n"
        puts question
    end

    def validate_user_input(input)
        until valid_input?(input)
            puts "Enter a valid input please. It must be something like: A5.\n"
            input = gets.chomp
        end
        input
    end

    def valid_input? (input)
        input.match?(/[A-Ha-h][1-8]/)
    end

    def user_input_to_coordinates(input)
        # split between non-digit and digit
        parts = input.split(/(?<=\D)(?=\d)/)

        row = LETTER_TO_I[parts[0].upcase]
        col = parts[1].to_i - 1

        [row, col]
    end

    def start_again?
        puts "Do you want to start again? Answer yes or no."
        answer = gets.chomp
            until answer.downcase.gsub(/[[:punct:]\s]/, '') == 'yes' ||
                answer.downcase.gsub(/[[:punct:]\s]/, '') == 'no'
                puts "Please type either yes or no."
                answer = gets.chomp
            end
        answer == 'yes'
    end
end