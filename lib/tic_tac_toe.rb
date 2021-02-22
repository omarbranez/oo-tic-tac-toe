class TicTacToe
    WIN_COMBINATIONS = [
        [0,1,2], #top row
        [3,4,5], #middle row
        [6,7,8], #bottom row
        [0,3,6], #left column
        [1,4,7], #middle column
        [2,5,8], #right column
        [0,4,8], #forward slash
        [2,4,6] #back slash
    ]
    def initialize(board=nil)
        @board = board || Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} " 
    end

    def input_to_index(user_move)
        user_move.to_i - 1 #since there is no 0 input allowed and we are asking for 1-9
    end

    def move(user_input, player_letter="X")
        @board[user_input] = player_letter #takes two arguments, one for the index of the board space and one for the letter of the player. X always goes first
    end

    def position_taken?(index) #FIX THIS FOR TRUTHINESS *fixed
        @board[index] != " " # return boolean value. if the board space does not contain a blank " ", the position is occupied by X or O
        #     return TRUE       #wont return truthy or falsey
        # else
        #     return FALSE
        # end
    end

    def valid_move?(position_to_check)
        !position_taken?(position_to_check) && position_to_check.between?(0,8) 
        #it is a valid move if the position is NOT occupied and the input is between 1 and 9         
    end

    def turn_count
        @board.count {|tokens| ["X","O"].include? tokens }
        #the number of turns passed is the same as the number of tokens already on the board
    end

    def current_player
        turn_count.even? ? "X" : "O" 
        #0 is even, so turn 0 would be X's turn. otherwise it would be O's turn.
    end

    def turn
        puts "YOUR MOVE! YUUUUUU GI OHHH" #tee hee
        player_move = gets #gets waits for user input of an integer between 1 and 9 (0-8 after parsing). set that equal to a temporary variable called player_move
        position_to_check = input_to_index(player_move) #parse the input so one is subtracted, then set that as the variable to be used as an argument for valid_move
        if valid_move?(position_to_check) #run valid move
            player_letter = current_player #if the move is valid, checks the current turn and determines whose move it is
            move(position_to_check, player_letter) #adds the index number and letter to the array via move 
        else
            turn #ask for a new input if the move is NOT valid
        end
        display_board #display the current board
    end

    def won?
        WIN_COMBINATIONS.detect do |combinations| @board[combinations[0]] == @board[combinations[1]] && @board[combinations[1]] == @board[combinations[2]] && position_taken?(combinations[0])
        
        #based on the class array with all possible combinations, check each combination and see if
        #that combination of indexes of elements exists in the current board
        #as per spec 0 4 8 means that the same letter exists in 0, 4, and 8 (0 is the same as 4 and 4 is the same as 8). additionally, every space MUST be occupied in that iteration
        #return the first element in the WIN_COMBINATIONS where this is true.
        end
    end

    def full?
        @board.none? {|board_spaces| board_spaces == " "} #check @board to make sure NONE of the spaces have " " strings
    end

    def draw?
        full? && !won? #check to see if both full? is TRUE _AND_ won? is not true 
    end

    def over?
        draw? || won? #check to see if EITHER draw? is TRUE _OR_ won? is true THIS CHECKS 1 TIME
        #won? || draw? # THIS CHECKS 0 TIMES
    end

    def winner
        if won?
        #if @board[won?[0]] != " " #checks if the first element from what is returned as the winning combination is not " ", otherwise it thinks " " won
            @board[won?[0]]         # return that element
        end
    end

    def play
        until over?
            turn
        end        
        if won?
            #won? 
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end
