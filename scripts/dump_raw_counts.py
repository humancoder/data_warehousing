import duckdb

# Connect to duckdb database = main.db
connection = duckdb.connect('main.db')

# Get all tables using duckdb SHOW command
show_all_tables = connection.sql('SHOW TABLES').fetchall()

# Append all table names to a list
table_names = []
for table in show_all_tables:
    table_names.append(table[0])

# Print header for output
print(f'table_name                    | Number of rows')

# Get and print number of rows for each table
for table in table_names:
    query = f"SELECT COUNT(*) FROM {table}"
    count = connection.sql(query).fetchall()
    print(f"{table.ljust(30)}| {count[0][0]}")

connection.close()







