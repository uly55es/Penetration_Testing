# What is SQL?

[MySQL for Absolute Beginners](https://www.elated.com/mysql-for-absolute-beginners/)

SQL is a language for storing, manipulating, and retrieving data from databases.

### Starting and stopping mysql:

```bash
service mysql start
service mysql stop
```

### Connect to a remote SQL database:

```bash
mysql -u [username] -p -h [host_ip}
mysql -u root -p -h 10.10.10.10
```

### Open SQL databse file locally

Change to the directory of the mysql file and type the following command:

* Note: In some cases you may have to run `mysql -p [password]` if the mysql system was configured to require authentication.

```bash
mysql -u [username] -p
```

Type "source" followed by the filename of the mysql database to specify that you wish to view its database.

```bash
source [sql_filename]
source employees.sql
```

### Displaying the databases

Type the following to see all of the relational databases:

```bash
SHOW DATABASES;
```

### Choosing a database to view:

```bash
USE [database_name]
USE employees;
```

### Displaying the tables in the selected database

Display which tables inside that database we selected previously:

```bash
SHOW TABLES;
```

View the table structure of the individual tables:

```bash
DESCRIBE [table_name]
DESCRIBE employees;
```

### Displaying all data stored in a specific table

```bash
SELECT * FROM [table_name]
SELECT * FROM employees;
```




