#projectname: Tic Tac Toe Game

.data
arr: .word '0' '0' '0' '0' '0' '0' '0' '0' '0' #game display
userchoice: .asciiz "Enter 'X' or 'O' :"
input: .asciiz "\enter nums from 1 till 9  :"
player1:  .asciiz "\nplayer 1 , you won: Congrats."
player2:  .asciiz"\nplayer 2,you won: Congrats"
playagain: .asciiz "\nWanna play again?"

.text
.globl main
main:

#print the user choice msg.
la $a0 , userchoice
li $v0 , 4
syscall

#reads and checks the user input.
li $v0 , 12
syscall

#moves input from $v0 to $s0 and ths will set the player 1
move $s0, $v0

#this will equate the s0 to X and will j to setplayer2 loop
beq $s0, 'X', setplayer2 
li $s1, 'X'  #load ascii code for X

#setting player 2.
setplayer2:
li $s1, 'O'  #load ascii code for O
la $s2, arr

#arguement for the Boarddisplay function 
move $a0, $s2 
#function that will display the game board with the changes after every move.
jal boardDisplay 

#this label will repeat the moves by the player 1, display whatever player 1 is suppose to do, promoting player 1.
player1_moves:
move $a0, $s2
move $a1, $s0 
#the input by player 1 will be its arguemnt.
jal placemark

move $a0, $s2 
jal boardDisplay 

move $a0, $s2
move $a1, $s0 

#checkWinner func will have two arguement 1) the input by the player 1 2) the arr.
jal checkWinner

#if $v0 = 0 j to player2_moves label to check if player 2 is a winner.
beq $v0, 0, player2_moves

li $v0, 4
la $a0, player1 #otherwis print the msg that player 1 is.
syscall

#if tbe player wants to play the game again jump to the nextGame label.
j nextGame

#this label will repeat the moves by the player 2.
player2_moves:

#the arguements for player 2 will be same as they are for player 1.
move $a0, $s2
move $a1, $s1

jal placemark 

move $a0, $s2

jal boardDisplay

move $a0, $s2
move $a1, $s1

jal checkWinner

beq $v0, 0 , player1_moves 
li $v0 , 4
la $a0, player2
syscall
j nextGame

#this label will be playing the game again.
nextGame:
la $a0, playagain
li $v0 , 4
syscall 

li $v0,  12
syscall

#if user input 'y', it will start the game again.
beq $v0, 'y', main

#ending the program.
end:
li $v0 , 10
syscall

#this function will do two things a) it will show how the game board is suppose to look like b)the display it has to return after every players move.
boardDisplay: 
li $t0, 1 #took a variable t0 and initialised it with 1, it will work as a counter
move $t1, $a0 #and moved the arr to t1
li $t3, 3 #t3 = 3, bcos grid size is 3 x 3.
li $a0, 10 #$a0 = max string length.

li $v0 , 11 #preparing to print characters.
syscall

#and through this loop we'll achieve the board display, everytime the players will choose numbrs between 1-9 it will display that.
displayloop:
bgt $t0, 9, endDisp #loop until greater than the last row.
lw $a0, ($t1) #$a0 now contains $t1[i]

li $v0, 11 
syscall
             #E.g. 0%3 = 0 , 1% 3= 1 2 % 3 = 2
div $t0, $t3 #divide loop counter by 3. this will determine which row and col we are in.
mfhi $t2 #if the remainder is 0 then 
beqz $t2, next #brach to next if equal.

#for display of space.
li $a0, 32 #ASCII code for space.
li $v0 , 11 #for printing characters.
syscall

addi $t0, $t0, 1 #increament loop counter.
addi $t1, $t1, 4 #and increment arr characters.
j displayloop #jump to displayloop label.

#it will show the next line display.
next:
li $a0 , 10  # $a0 = max string length

li $v0, 11
syscall

addi $t0, $t0, 1  #loop counter++
addi $t1, $t1, 4 #arr ++
j displayloop

endDisp:
jr $ra

#this will show on the game board what the players have marked so far and will return the board with marker spots.
placemark:
move $t0, $a0

la $a0 , input #enter number 1-9
li $v0 , 4
syscall

li $v0 ,5  #to input int.
syscall 

addi $v0 , $v0 , -1 
mul $v0 , $v0 , 4
add $t0, $t0, $v0 
lw $t1, ($t0) 

beq $t1,'0', change #if t1 = ' 0 ' j to change. else return.
jr $ra

change: 
sw $a1, ($t0) #arr ko set krdo user ki input se. 
jr $ra #return function.

#this function will tell which winner won after all the moves are done by the players. this will check all the rows, cols, diagonally and return the player who won.
checkWinner:

move $t0, $a0 
li $t1, 1 #counter.
li $v0, 1 #assume valid.

loop:
bgt $t1, 9 , endcheckwinner 
lw $t2 , ($t0) #selecting index what char we are looking at. 

#row check.
beq $t2, $a1, nextCol2 

addi $t0, $t0, 4 #update arr to point to next element.
lw $t2, ($t0) #next char
addi $t1, $t1, 1 #counter increment.
beq $t2, $a1, nextCol2 
addi $t0, $t0, 4 
lw $t2, ($t0)
addi $t1, $t1, 1
beq $t2, $a1, nextCol3

li $v0, 0
j endcheckwinner

#to check colum2
nextCol2:
addi $t0, $t0, 4
lw $t2, ($t0)
addi $t1, $t1, 1
beq $t2, $a1, nextCol3

addi $t0, $t0, 8 
lw $t2, ($t0)
addi $t1, $t1, 1
beq $t2, $a1, nextRow

addi $t0, $t0, 8
lw $t2, ($t0)
addi $t1, $t1, 1
beq $t2, $a1, nextDiag

#to check colum3
nextCol3:
addi $t0, $t0 , 4
lw $t2, ($t0)
addi $t1, $t1, 1
beq $t2, $a1, endcheckwinner
j loop

#to check nextrow
nextRow:
addi $t0, $t0, 12 
lw $t2, ($t0)
addi $t1, $t1, 1
beq $t2, $a1, endcheckwinner
j loop

#checking diagonals.
nextDiag:
addi $t0 , $t0 , 16
lw $t2, ($t0)
addi $t1, $t1, 1
beq $t2, $a1, endcheckwinner 
j loop

endcheckwinner:
jr $ra #jump to return address in $ra which is stored by jal instruction.




 

