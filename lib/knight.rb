require 'set'

class Knight
    attr_reader :path

    MOVE_OFFSETS = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [-2, -1], [-2, 1],  [2, -1]]

    def initialize (start, destination)
        @start = start
        @destination = destination
    end

    def generate_possible_moves(position) 
        possible_moves = []

        MOVE_OFFSETS.each do |offset|
            x = position[0] + offset [0]
            y = position[1] + offset [1]
            possible_moves.push([x, y]) if x.between?(0, 7) && y.between?(0, 7) 
        end

        possible_moves
    end

    def knight_moves
        queue = [[@start]]
        visited = Set.new([@start])

        until queue.empty?
            @path = queue.shift
            current_position = @path.last

            if current_position == @destination
                return @path
            end

            generate_possible_moves(current_position).each do |next_position|
                unless visited.include?(next_position)
                    visited.add(next_position)
                    queue << @path + [next_position]
                end
            end
        end
        
        return nil
    end
end