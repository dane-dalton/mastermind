# Mastermind
A game of mastermind written in Ruby and played in the console against a computer (AI to come).
## Rules
The rules don't read well, but the game is quite simple. It is a lot like wordle if you are familiar.

-There is a Coder and a Code Breaker

-The Coder selects a sequence of set colors in any order they choose; This is the code

-The Code Breaker will make a blind guess at the code to start and will recieve up to 4 Black or White pins that appear in no specific order

---Black pins: Each one is an indication that one of your guesses is correct and in the right location

---White pins: Each one is an indication that one of your guesses is correct, but it is not in the right position

-The Code Breaker gets 10 guesses to come up with the code, otherwise the Coder wins

*Code length, number of rounds, and color pool can all be modified to adjust game difficulty

## Goals
-Keep as much information of the Game class private as possible. Especially key factors to the game like the code.

-Create more modules to clean up the Game class

-Write an AI to play in the most optimal way and ideally win every game with the current code and game length
---Research the best ways to win in Mastermind

-Write the 'play' method in the Game class this time