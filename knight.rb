class Knight
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
            possible_moves.push[x, y] if x.between?(0, 7) && y.between?(0, 7)
        end

        possible_moves
    end
end