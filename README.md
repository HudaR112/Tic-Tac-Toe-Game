# Tic-Tac-Toe-Game
It is a 3x3 tic-tac-toe game created using MIPS software.It is for two players and the first player that manages to get three ‘X’s or ‘O’s  in a line (either in row, or column,or diagonally) will be considered as a winner and the game starts again if the player wants to.

# Description
- The program starts by asking the player to choose their sides , 'X' or 'O' then by using a label setplayer_2 it will player 2 the side which is left. Meaning if player1 chooses X, O will be given to player and vice versa with the help of this label.

- After this a function namely 'boardDisplay' will be called that is going to display the board because as soon as the players got their sides board has to be displayed. The argument it took is the char array(arr) consisting of 9 '0's as it will be a 3x3 matrix, it will display the whole string of '0's in the form of a board by using a loop (displayloop)

- This loop will display it by first dividing the loop counter by '3' because the board is 3 x 3, and then displaying space between the board and printing the next row by using  a label 'next'.

- When all the work is done in this function a label 'endDisp' is called to return to the function from where it was called.

- player1_moves label will be followed by it that is going to repeat the moves of player 1 by calling a function 'placemark', this function will be asking the players to choose where to mark their turn and whatever their choice will be it will be put their name either 'X' or 'O' instead of '0'.

- Then 'boardDisplay' function will be called again this time to display the board  every time the player has made his turns.

- Then the checkWinner function will be called that will loop through all of the winning movesets, i.e. rows,cols,diagonals to check if player1 is a winner. The counter will keep moving through column 1  by  keeping  a track of the previous grid character if it equals the present grid character it will keep 
moving because maybe player 1 is the winner if not it will move to the next columns and then diagonals.

- If player1 is not the winner it will jump to label player2_moves where the same steps from 4-6 will be followed. If player2 is  a winner it will print a message congratulating player2 else player1.

- Then  it will jump to the label 'nextGame' this label will ask the player to play the game again if the player enters 'y' it will start the game again.

- If the response will be 'N' the program will be terminated.

