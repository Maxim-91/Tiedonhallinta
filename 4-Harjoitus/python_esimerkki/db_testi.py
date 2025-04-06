import mysql.connector
from my_functions import *

# Luodaan tietokantayhteys
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="salasana",
    database="classicmodels",
    port=3306 # Oletusportti, jota tietokantapalvelin käyttää
)

mycursor = fetch_all_customers(mydb)
add_office(mydb, mycursor)