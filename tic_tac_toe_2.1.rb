
###############################################################################
##                                                                           ##
##                           TERMINAL TIC-TAC-TOE                            ##
##                               (Version 2.1)                               ##
##                                                                           ##
##                               Matthew  Main                               ##
##                        Flatiron School Application                        ##
##                                                                           ##
###############################################################################


class Game

	def initialize
		@user_mark = "⨉"; @computer_mark = "◯"
		generate_cell_data(3,3)
		display_board		
		intro
		user_turn
	end


	def generate_cell_data(grid_width, grid_height)																	  #  "generate_cell_data": creates a two-dimensional array that stores each cell's
	@cells_arr = []																																		#  coordinates (e.g., "a1") and its status as empty or marked. Because this
		letter = "a" 																																		#  method is called for a 3x3 grid in "intitialize", the resulting array is:
    grid_width.times do 																														#
      number = 1																																		# 		@cells_arr = [@a1,@a2,@a3,@b1,@b2,@b3,@c1,@c2,@c3]
      grid_height.times do 																													# 		=>
        @cells_arr.push(instance_variable_set("@" + letter + number.to_s, [					#  		[["a1", " "], ["a2", " "], ["a3", " "],
            letter + number.to_s," "]))																							# 		 ["b1", " "], ["b2", " "], ["b3", " "],  		
        number = number.next																												# 	 	 ["c1", " "], ["c2", " "], ["c3", " "]]
      end 																																					
      letter = letter.next																													
    end 																																						
	end


	def intro
		puts "\n" * 54
		puts "W E L C O M E\n".center(80)
		puts "T O\n".center(80)		
		puts "T I C  -  T A C  -  T O E\n".center(80)		
		puts "\n" * 9
		sleep 2
		for i in 9..19 do
			puts "\n" * 54; puts "T I C  -  T A C  -  T O E\n".center(80)		
			puts "\n" * i; sleep 0.075
		end
		sleep 0.33; display_board("To make a move, just type a letter and number,"+
			" like \"a3\" or \"b1\". Got it?", "HIT ENTER TO START!")
		gets
		display_board; sleep 0.3
	end


	def display_board(message1=' ', message2 = ' ')
	  puts "\n" * 31; puts "T I C  -  T A C  -  T O E".center(80); puts "\n" * 3
	  puts "    a   b   c    ".center(80)
	  puts "  ╔═══╦═══╦═══╗  ".center(80)
	  puts "1 ║ #{@a1[1]} ║ #{@b1[1]} ║ #{@c1[1]} ║  ".center(80)
	  puts "  ╠═══╬═══╬═══╣  ".center(80)
	  puts "2 ║ #{@a2[1]} ║ #{@b2[1]} ║ #{@c2[1]} ║  ".center(80)
	  puts "  ╠═══╬═══╬═══╣  ".center(80)
	  puts "3 ║ #{@a3[1]} ║ #{@b3[1]} ║ #{@c3[1]} ║  ".center(80)
	  puts "  ╚═══╩═══╩═══╝  ".center(80)
	  puts "\n" * 3; puts "#{message1}".center(80)
	  puts "\n" * 2; puts "#{message2}".center(80); puts "\n" * 2
	  print "".rjust(39)
	end


	def user_turn
	  def get_user_entry
	  	@move = gets.chomp.downcase
			index = 0																																			#  
			for cell in @cells_arr																												#  creates move_index, a num var matching @cells_arr index for @move
				move_index = index if @move == cell[0]																			#
				index += 1																																	#
			end
			if @cells_arr.all? {|all_cells| all_cells[0] != @move}
		    display_board; sleep 0.5;
		    display_board("So, um ... yeah ... \"#{@move}\" isn't a valid entry.", 
		    	"Maybe try again?")
		    get_user_entry
			elsif @cells_arr[move_index][1] != " "
	      display_board; sleep 0.5;
	      display_board("That move has already been made!","Try something that'"+
	      	"s, well . . . at least not \"#{@move}\".")
	      get_user_entry
			else
	  		place_mark(@user_mark, move_index)
			end
	  end
	  display_board("What's your move?")
	  get_user_entry
	  check_endgame
	  display_board; sleep 0.33; display_board("Nice move."); sleep 1
	  computer_turn
	end


	def computer_turn
		def get_computer_entry
			move_index = rand 0..8
			if @cells_arr[move_index][1] != " "
				get_computer_entry
			else
				place_mark(@computer_mark, move_index)
			end
		end
		display_board; sleep 0.33;
	  display_board(" Computer's turn.  "); sleep 0.5
	  display_board(" Computer's turn.. "); sleep 0.5
	  display_board(" Computer's turn..."); sleep 0.75
		get_computer_entry
	  display_board; sleep 0.5
	  check_endgame
	  user_turn
	end


	def place_mark(whose_mark, cell_arr_index)
		def position_mark(whose_mark, cell_arr_index)
			@cells_arr[cell_arr_index][1] = whose_mark
		end
		2.times do	
			position_mark(whose_mark,cell_arr_index); display_board; sleep 0.33
			position_mark(" ",cell_arr_index); display_board; sleep 0.25
		end
		position_mark(whose_mark,cell_arr_index); display_board; sleep 0.33
		@wins=[[@a1[1],@b1[1],@c1[1]],[@a2[1],@b2[1],@c2[1]],[@a3[1],@b3[1],@c3[1]], 
	      	 [@a1[1],@a2[1],@a3[1]],[@b1[1],@b2[1],@b3[1]],[@c1[1],@c2[1],@c3[1]],	
	   	  	 [@a1[1],@b2[1],@c3[1]],[@a3[1],@b2[1],@c1[1]]]	
	end

	def check_endgame
	  @wins.each do |i|  
	  	if i == ["⨉","⨉","⨉"]
	  		display_board; sleep 0.5
	  		win_message = "You won! Congratulations!"
	  		display_board(win_message); sleep 1
	  		play_again?(win_message)
	  	elsif i == ["◯","◯","◯"]
	  		lose_message = "Oh no! You lost..."
	  		display_board; sleep 0.5
	  		display_board(lose_message); sleep 1
	  		play_again?(lose_message)						
	  	end	
	  end
		if @cells_arr.all? {|cell| cell[1] != ' '}  #checks for draw
			draw_message = "...Well, looks like it's a draw. Yeah. Boring."
	  	display_board; sleep 0.5
	  	display_board(draw_message); sleep 1
	  	play_again?(draw_message)
		end
	end


	def play_again?(message1)
		display_board(message1, "Wanna play again?")
		answer = gets.downcase
		if answer =~ /no|na|neg|n't|sor/ && !(answer =~ /why not/)
			display_board; sleep 0.33
			display_board("Okay. Thanks for playing! Bye!"); sleep 2
			exit
		elsif answer =~ /ye|yup|sure|ok|hu|aff|right|gue|sup|go|do|would|I'd|ly|
			  why not/
			display_board; sleep 0.33
			display_board("Great!"); sleep 1
			Game.new
		else
			display_board; sleep 0.33;
			play_again?("Sorry, didn't quite get that. Answer \"yes\" or \"no\".")
		end
	end  

end

Game.new








###########################   MAKE A TIC-TAC-TOE GAME   #########################


#*************** Version 1 *****************#

#[X] create board: a 3x3 grid with a coordinate var for each cell 
	#[X] create nine cell vars, each named with a cell coordinate
	#[X] create an arr of coordinates as string values for indexing numerically
	#[X] create vars for X's and O's marks
	#[X] create a putsable ASCII grid for the board that includes cell vars
	#[X] create a display_board method that displays board in its current state

#[X] create an arr of cell vars to store cell values and track open cells
#[X] create a wins array for all combinations of grid vars that result in a win	
#[X] creat a method for updating open cells and wins vars

#[X] create method for marking the board using case statement

#[X] create a user_turn method for processing moves & displaying them
	#[X] ask user for entry
		#[X] check that entry is valid syntax; if not, ask again until valid
		#[X] check that entry is an open cell; if not, ask again until open cell
	#[X] use marking method to assign move to corresponding grid var
	#[X] update arr of cell vars to keep track of open cells
	#[X] check for win or draw
	#[X] display updated board	

#[X] create a computer_turn method for processing moves & displaying them
	#[X] create an array of grid coordinates as strings
	#[X] create a number var assigned to a random number from 0 to 8
	#[X] create a string var to store coordinate corresponding to the random number
	#[X] create a string var to store cell value corresponging to the random number
		#[X] check if cell value is an open cell; if not, re-run method
	#[X] use marking method to assign move to corresponding grid var
	#[X] update arr of cell vars to keep track of open cells
	#[X] check for win or draw
	#[X] display updated board	

#[X] create a method to check for wins then draws after every turn
	#[X] check for wins
		#[X] check wins array for sequences of three X's or O's
		#[X] if win found, announce result
  #[X] check for draws
  	#[X] check each element in the open cell arr for open cells
  	#[X] if no open cells, announce draw
	#[X] offer option to play again or quit
		  #[X] if play again, mechanism to re-start game
  		#[X] if quit, mechanism to exit program

#[X] create game-flow sequence
	#[X] weclome message
	#[X] user's turn
		#[X] unless win or draw, pass turn to computer
	#[X] computer's turn
		#[X] unless win or draw, pass turn to user
	#[X] when win or draw, game over; ask to play again or quit


#*************** Version 2 *****************#

#[X] add a simple animated intro
	#[X] create animated welcome to Tic-Tac-Toe message ->
	#[X] basic instructions for using grid (-> enter gameplay)

#[X] enhance game flow 
	#[X] create display "screen" method that centers/fixes board and messages on call
		#[X] include puts-newlines to make each refresh appear to be on a fixed screen
		#[X] include variables for 2 lines of messages beneath board
	#[X] write messages for each step/response
	#[X] add sleep delays between messags and turns

#[X] animate each move so new X/O blinks before becoming fixed
	#[] create method that toggles mark method from ' ' to X/O with sleep-delays
	#[] then pass control to mark method to log move


#********************************* Additional ***********************************#


##### better code possibities:

# +use hashes for cell vars so can assign both id and mark values at once
# +use hashes for win array so can track which line is a winner, and blink at end


##### more game-play possibilities:

# +medium computer option? (*at least this: plays/blocks twos-in-a-row)
# +hard computer option?
# +two-player option? (...probably not)
# +coin toss to see who goes first?
# +score tracker?


##### more aesthetics possibilities:

# +center game play (*yes, but keep non-centered version too)
# +animations, opening sequence, etc.

# +make larger board with 2x2 ASCII-shape X's & O's?
# +flashing three-in-a-row on win?
# +center for repl.it?
# +try to alter or respond to terminal dimensions?
# +put on web page (...probably not)

