# Mastermind
A game of mastermind written in Ruby and played in the console against a computer (AI to come).
## Rules
The rules don't read well, but the game is quite simple. It is a lot like wordle if you are familiar.

-There is a Coder and a Code Breaker

-The Coder selects a sequence of set colors in any order they choose; This is the code

-The Code Breaker will make a blind guess at the code to start and will recieve up to 4 Black or White pins that appear in no specific order

---Black pins: Each one is an indication that one of your guesses is correct and in the correct location

---White pins: Each one is an indication that one of your guesses is correct, but it is not in the correct position

-The Code Breaker gets 10 guesses to come up with the code, otherwise the Coder wins

*Code length, number of rounds, and color pool can all be modified to adjust game difficulty

## Goals
-Keep as much information of the Game class private as possible. Especially key factors to the game like the code.

-Create more modules to clean up the Game class

-Write an AI to play in the most optimal way and ideally win every game with the current code and game length
---Research the best ways to win in Mastermind with the standard rule set (The current game rules)

-Write the 'play' method in the Game class this time

## Resources
-A lecture by Adam Forsyth on solving logic games with Python was extremely helpful for my approach in creating an AI for the game since I have not written logic in this depth before
---https://www.youtube.com/watch?v=2iCpnWYXPik 

-Finding the maximum minimum (minimax) solutions yields the quickest results for Mastermind, and the Minimax wikipedia page was used for more information on this concept
---https://en.wikipedia.org/wiki/Minimax#Pseudocode