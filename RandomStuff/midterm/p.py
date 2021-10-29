from re import S
import sqlite3
import pandas as pd


database = r'ships.sqlite'

conn = sqlite3.connect(database)

queries = []

#Ships = pd.read_csv('Ships.csv', delimiter=',')
#Ships = pd.read_excel('Classes.xlsx')
#Ships = pd.read_csv('Outcomes.csv', delimiter=',')
Ships = pd.read_excel('Battles.xlsx')
print(Ships)
query = """INSERT INTO Outcomes (name, date) VALUES"""
for i, r in Ships.iterrows():
    s = """ ("%s", "%s"), """ %(r['name'], r['date'])
    query += s
query = query[:-2]
print(query)