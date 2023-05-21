#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ $# -eq 0 ]]
then 
 echo "Please provide an element as an argument." 
fi

ARGUMENT=$1

if [[ $# -eq 1 ]]
then
   if [[ $ARGUMENT =~ ^[0-9]+$ ]]
   then
      ELEMENT_INFO=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $ARGUMENT") 
         if [[ -z $ELEMENT_INFO ]]  
         then
            echo "I could not find that element in the database."
          else
           E_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ARGUMENT")
           A_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $ARGUMENT")
           E_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ARGUMENT")
           T_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $A_NUM")
           E_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $T_ID")
           A_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ARGUMENT")
           M_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ARGUMENT")
           B_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ARGUMENT")
            echo "The element with atomic number $A_NUM is $E_NAME ($E_SYMBOL). It's a $E_TYPE, with a mass of $A_MASS amu. $E_NAME has a melting point of $M_POINT celsius and a boiling point of $B_POINT celsius."
          fi 
    else
       ELEMENT_SYMBOL=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$ARGUMENT'")
         if [[ -z $ELEMENT_SYMBOL ]]
         then
            ELEMENT_NAME=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$ARGUMENT'")
             if [[ -z $ELEMENT_NAME ]]
             then   
              echo "I could not find that element in the database."
              else
              E_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$ARGUMENT'")
              A_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$ARGUMENT'")
              E_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$ARGUMENT'")
              T_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $A_NUM")
              E_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $T_ID")
              A_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $A_NUM")
              M_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $A_NUM")
              B_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $A_NUM")
              echo "The element with atomic number $A_NUM is $E_NAME ($E_SYMBOL). It's a $E_TYPE, with a mass of $A_MASS amu. $E_NAME has a melting point of $M_POINT celsius and a boiling point of $B_POINT celsius."
              fi
          else
             E_NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$ARGUMENT'")
           A_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$ARGUMENT'")
           E_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$ARGUMENT'")
           T_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $A_NUM")
           E_TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $T_ID")
           A_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $A_NUM")
           M_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $A_NUM")
           B_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $A_NUM")
            echo "The element with atomic number $A_NUM is $E_NAME ($E_SYMBOL). It's a $E_TYPE, with a mass of $A_MASS amu. $E_NAME has a melting point of $M_POINT celsius and a boiling point of $B_POINT celsius."
          fi
     fi     
fi


