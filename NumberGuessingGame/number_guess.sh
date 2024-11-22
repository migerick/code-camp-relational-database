#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

# Check if the user exists
USER=$($PSQL "SELECT user_id, games_played, best_game FROM users WHERE username='$USERNAME'")
if [[ -z $USER ]]; then
  # New user
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
else
  # Existing user
  IFS="|" read USER_ID GAMES_PLAYED BEST_GAME <<< "$USER"
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# Generate secret number
SECRET_NUMBER=$((RANDOM % 1000 + 1))
echo "Guess the secret number between 1 and 1000:"
GUESSES=0

while true; do
  read GUESS
  ((GUESSES++))

  # Validate input
  if ! [[ $GUESS =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
    continue
  fi

  # Check guess
  if (( GUESS < SECRET_NUMBER )); then
    echo "It's higher than that, guess again:"
  elif (( GUESS > SECRET_NUMBER )); then
    echo "It's lower than that, guess again:"
  else
    echo "You guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

    # Update database
    if [[ -z $USER ]]; then
      # New user
      USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
      GAMES_PLAYED=0
      BEST_GAME=$GUESSES
    fi

    GAMES_PLAYED=$((GAMES_PLAYED + 1))
    if [[ -z $BEST_GAME || $GUESSES -lt $BEST_GAME ]]; then
      BEST_GAME=$GUESSES
    fi

    UPDATE_USER=$($PSQL "UPDATE users SET games_played=$GAMES_PLAYED, best_game=$BEST_GAME WHERE user_id=$USER_ID")
    INSERT_GAME=$($PSQL "INSERT INTO games(user_id, guesses) VALUES($USER_ID, $GUESSES)")

    break
  fi
done
