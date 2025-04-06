def fetch_all_customers(mydb):
    # haetaan "kursori", jonka avulla voidaan suorittaa komentoja
    mycursor = mydb.cursor()
    mycursor.execute("select * from customers")
    myresult = mycursor.fetchall()  # Haetaan tulokset listana
    # print(myresult)
    for row in myresult:
        print(row[1])  # Nyt tulostettaisiin jokaiselta riviltä toinen solu eli asiakkaan nimi
    return mycursor

def add_office(mydb, mycursor):
    # Testataan offices tauluun datan lisäämistä (insert komentoa)
    sql = ("insert into offices (officeCode, city, phone, addressLine1, country, postalCode, territory) "
           "values (%s, %s, %s, %s, %s, %s, %s)")
    # Annetaan tässä arvot vain kovakoodattuna eikä kysytä niitä käyttäjältä
    # Arvot annetaan tuplena eli ns. read-only listana
    my_values = ("12", "Rovaniemi", "+358 123123", "Valtakatu 111", "Finland", 96100, "Rovaniemi")
    # Seuraavaksi ajetaan komento
    mycursor.execute(sql, my_values)
    # Sen jälkeen tarvitaan vielä kommitointi eli lopullisesti varmennetaan komento kantaan.
    mydb.commit()
