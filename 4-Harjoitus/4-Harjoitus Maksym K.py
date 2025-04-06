# Task: Implement a console application which has the following options for user to choose.
# (You get two points from each feature)

import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="Cjytxrj91*",
    database="world",
    port=3306
)

#------------------------------------------------------------------------------------------
# a. Show all the countries, continent and independent year
# (only countries table needed)
print("a. Show all the countries, continent and independent year (only countries table needed):\n")
mycursor = mydb.cursor()
mycursor.execute("SELECT Name, Continent, IndepYear FROM country")
for row in mycursor.fetchall():
    print(row)
print() #Teen sisennyksen (tyhjä rivi)

#------------------------------------------------------------------------------------------
# b. Show all cities whose Population is more than 1 million.
# Order the results to descending order
print("b. Show all cities whose Population is more than 1 million. Order the results to descending order:\n")
mycursor = mydb.cursor()
mycursor.execute("SELECT Name, Population FROM city WHERE Population > 1000000 ORDER BY Population DESC")
for row in mycursor.fetchall():
    print(row)
print() #Teen sisennyksen (tyhjä rivi)

#------------------------------------------------------------------------------------------
# c. Ask user which country’s cities he want to see.
# Show all cities only from this country
print("c. Ask user which country’s cities he want to see. Show all cities only from this country:")

# Teen ohjelman silmukassa, silmukka keskeytyy kun maa syötetään tietokannasta
while True:
    country = input("Enter country name:\n")

    # Maan olemassaolon tarkistaminen tietokannasta
    mycursor = mydb.cursor()
    mycursor.execute("SELECT Name FROM country WHERE Name = %s", (country,))
    result = mycursor.fetchone()

    if result is None:  # Jos maata ei löydy
        print("Country not found, enter another.")
    else:
        # Maa löydetty, näyttää kaikki tämän maan kaupungit
        mycursor.execute("SELECT Name FROM city WHERE CountryCode = (SELECT Code FROM country WHERE Name = %s)",
                         (country,))
        cities = mycursor.fetchall()
        print(f"Cities in {country}:")
        for row in cities:
            print(row[0])  # Tulosta vain kaupungin nimi (row[0])
        break  # Silmukasta poistuminen

print() #Teen sisennyksen (tyhjä rivi)

#------------------------------------------------------------------------------------------
# d. Ask user which Continent’s Life Expectancy he is interested in and show the result to user
print("d. Ask user which Continent’s Life Expectancy he is interested in and show the result to user:")

# Teen ohjelman silmukassa, silmukka keskeytyy kun maa syötetään tietokannasta
while True:
    continent = str(input("Enter continent:\n"))

    # Tarkistan maanosan olemassaolon tietokannasta.
    mycursor = mydb.cursor()
    mycursor.execute("SELECT Continent FROM country WHERE Continent = %s", (continent,))
    result = mycursor.fetchall()

    if not result:  # Jos maanosaa ei löydy
        print("Continent not found, enter another.")
    else:
        # Manner löydetty, näytän kunkin maan elinajanodotteen tällä mantereella
        mycursor.execute("SELECT Name, LifeExpectancy FROM country WHERE Continent = %s", (continent,))
        countries = mycursor.fetchall()
        for country, life_expectancy in countries:
            print(f"{country}: {life_expectancy}")  # Tulos
        break  # Silmukasta poistuminen

print()  # Teen sisennyksen (tyhjä rivi)

#------------------------------------------------------------------------------------------
# e. Ask the country name and show how many different languages are spoken this specific country
print("e. Ask the country name and show how many different languages are spoken in this specific country:")

while True:
    country = str(input("Enter country name:\n"))

    mycursor = mydb.cursor()

    # Tarkista, onko syötetty maa olemassa ja hanki sen koodi
    mycursor.execute("SELECT Code FROM country WHERE Name = %s", (country,))
    result = mycursor.fetchone()

    if result is None: # Jos maata ei löydy
        print("Country not found, please enter a valid country name.")
    else:
        # Maa löydetty
        country_code = result[0]  # Maakoodi

        # Saan tietyssä maassa puhuttujen kielten määrän
        mycursor.execute("SELECT COUNT(*) FROM countrylanguage WHERE CountryCode = %s", (country_code,))
        language_count = mycursor.fetchone()[0]

        print(language_count) # Tulos

        # Saan luettelon näistä kielistä
        mycursor.execute("SELECT Language, IsOfficial, Percentage FROM countrylanguage WHERE CountryCode = %s",
                         (country_code,))
        languages = mycursor.fetchall()

        # Annan tiedot numeroinnilla
        n = 1
        print("| #  | Language             | IsOfficial | Percentage |")
        for lang in languages:
            print(f"| {n:<2} | {lang[0]:<20} | {lang[1]:<10} | {lang[2]:<10} |")
            n += 1

        break  # Silmukasta poistuminen

print()  # Teen sisennyksen (tyhjä rivi)

#------------------------------------------------------------------------------------------
# f. Ask user city name, country, district and population and add it to cities table.
# Note that you ask country name, not country code.
# You need to fetch corresponding country code with sql query before insert.
print("f. Ask user city name, country, district and population and add it to cities table. Note that you ask country name, not country code. You need to fetch corresponding country code with sql query before insert:")

name = str(input("City name:\n"))
country = str(input("Country name:\n"))
district = str(input("District:\n"))
population = int(input("Population:\n"))
mycursor = mydb.cursor()
mycursor.execute("SELECT Code FROM country WHERE Name = %s", (country,))
country_code = mycursor.fetchone()[0]
sql = "INSERT INTO city (Name, CountryCode, District, Population) VALUES (%s, %s, %s, %s)"
mycursor.execute(sql, (name, country_code, district, population))
mydb.commit()

print()  # Teen sisennyksen (tyhjä rivi)

#------------------------------------------------------------------------------------------
# g. Updating city population. Ask user which city he wants to update and new population
print("g. Updating city population. Ask user which city he wants to update and new population:")

name = str(input("City name:\n"))
population = int(input("New population:\n"))
mycursor = mydb.cursor()
mycursor.execute("UPDATE city SET Population = %s WHERE Name = %s", (population, name))
mydb.commit()

print()  # Teen sisennyksen (tyhjä rivi)

#------------------------------------------------------------------------------------------
# h. Delete a city by asking the name of the city from the user
print("h. Delete a city by asking the name of the city from the user:")

name = str(input("City name:\n"))
mycursor = mydb.cursor()
mycursor.execute("DELETE FROM city WHERE Name = %s", (name,))
mydb.commit()
