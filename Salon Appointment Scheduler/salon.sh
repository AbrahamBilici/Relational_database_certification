#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU(){
 echo -e "Welcome to My Salon, how can I help you?\n"
 echo -e "1) cut\n2) color\n3) perm\n4) style\n5) trim" 
 read SERVICE_ID_SELECTED

case $SERVICE_ID_SELECTED in
 1) CHOOSE_SERVICE ;;
 2) CHOOSE_SERVICE ;;
 3) CHOOSE_SERVICE ;;
 4) CHOOSE_SERVICE ;;
 5) CHOOSE_SERVICE ;;
 *) CHOOSE_SERVICE ;;
esac


 
}

CHOOSE_SERVICE() {
#if input is not a number
 if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
 then
 # send to not valid service menu
    NOT_A_VALID_SERVICE
 else
  # get service 
  SERVICE=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  

   #if is not a valid service
   if [[ -z $SERVICE ]]
   then
    # send to not a valid service menu
    NOT_A_VALID_SERVICE
   else
    CUSTOMER_INFO
   fi

 fi

}

NOT_A_VALID_SERVICE() {
  echo -e "\nI could not find that service. What would you like today?" 
  echo -e "\n1) cut\n2) color\n3) perm\n4) style\n5) trim"
 read SERVICE_ID_SELECTED

case $SERVICE_ID_SELECTED in
 1) CHOOSE_SERVICE ;;
 2) CHOOSE_SERVICE ;;
 3) CHOOSE_SERVICE ;;
 4) CHOOSE_SERVICE ;;
 5) CHOOSE_SERVICE ;;
 *) CHOOSE_SERVICE ;;
esac

}


CUSTOMER_INFO() {
    
    # get phone number
    echo -e "\nWhat is your phone number?"
    read CUSTOMER_PHONE 

    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    # if customer doesn't exist
    if [[ -z $CUSTOMER_NAME ]]
    then 
      # get new customer name
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      #insert new customer
      INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
      GET_APPOINTMENT
     else
       GET_APPOINTMENT
     fi

}

GET_APPOINTMENT() {
  echo -e "\nWhat time would you like your $(echo $SERVICE | sed -r 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $(echo $SERVICE | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."

}


MAIN_MENU

