#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    RESULT=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using(type_id) where atomic_number = $1;")
  else
    RESULT=$($PSQL "select * from elements inner join properties using(atomic_number) inner join types using(type_id) where symbol = '$1' or name = '$1';")
  fi

  if [[ -z $RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE < <(echo "$RESULT")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi
