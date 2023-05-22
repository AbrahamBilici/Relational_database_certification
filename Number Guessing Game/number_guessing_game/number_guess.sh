#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

INFORMATION(){
  echo -e "\nEnter your username:"
  read USERNAME
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
 if [[ -z $USER_ID ]]
 then
 echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")  
  else
  ROW_COUNT=$($PSQL "SELECT COUNT(user_id) FROM games WHERE user_id = $USER_ID")
  BEST_GAME=$($PSQL "SELECT MIN(number_of_guesses) FROM games WHERE user_id = $USER_ID")
  echo -e "\nWelcome back, $USERNAME! You have played $ROW_COUNT games, and your best game took $BEST_GAME guesses."
  fi
  GAME
}


GAME(){
TARGET=$(( 1 + $RANDOM % 1000 ))
echo -e "\nGuess the secret number between 1 and 1000:"

COUNT=0

while true; do
  read GUESS
#check if the guess is correct
  if [[ $GUESS =~ ^[0-9]+$ ]]
   then
   if [[ $GUESS = $TARGET ]]
   then
   COUNT=$(($COUNT + 1))
   INSERT_GAME=$($PSQL "INSERT INTO games(user_id,number_of_guesses) VALUES($USER_ID, $COUNT)")
   echo "You guessed it in $COUNT tries. The secret number was $TARGET. Nice job!"
   break
   elif [[ $GUESS -lt $TARGET ]]
   then
   COUNT=$(($COUNT + 1))
   echo "It's lower than that, guess again:"
   elif [[ $GUESS -gt $TARGET ]]
   then
   COUNT=$(($COUNT + 1))
   echo "It's higher than that, guess again:"
   fi
  else
   echo "That is not an integer, guess again:"
  fi 

  
done

}
INFORMATION