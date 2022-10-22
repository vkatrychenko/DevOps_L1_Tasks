## MySQL homework

**Create a database**

`create database devops_l1;`

**Create mysql scheme (3 tables)**

```
create table devops_l1_members (
   member_id INT NOT NULL AUTO_INCREMENT,
   member_name VARCHAR(100) NOT NULL,
   member_location VARCHAR(40) NOT NULL,
   submission_date DATE,
   PRIMARY KEY ( member_id )
);

create table devops_l1_member_status (
   member_id INT NOT NULL,
   member_status VARCHAR(40) NOT NULL,
   PRIMARY KEY ( member_status ),
   FOREIGN KEY ( member_id ) REFERENCES devops_l1_members( member_id) ON DELETE CASCADE
);

create table devops_l1_tasks (
   member_id INT NOT NULL,
   member_task VARCHAR(40) NOT NULL,
   FOREIGN KEY ( member_task ) REFERENCES devops_l1_member_status( member_status) ON DELETE CASCADE
);
```
> ON DELETE CASCADE clause in MySQL is used to automatically remove the matching records from the child table when we delete the rows from the parent table.

![tables](images/Screenshot%202022-10-22%20at%2021.07.00.png)

**Fill the tables**

`INSERT INTO devops_l1_members (member_name, member_location) VALUES ('Vlad', 'Dnipro');`
`INSERT INTO devops_l1_member_status (member_id,member_status) VALUES ('1', 'done');`
```
MariaDB [devops_l1]> SELECT * FROM devops_l1_members;
+-----------+-------------+-----------------+-----------------+
| member_id | member_name | member_location | submission_date |
+-----------+-------------+-----------------+-----------------+
|         1 | Vlad        | Dnipro          | NULL            |
+-----------+-------------+-----------------+-----------------+
1 row in set (0.001 sec)

MariaDB [devops_l1]> SELECT * FROM devops_l1_member_status;
+-----------+---------------+
| member_id | member_status |
+-----------+---------------+
|         1 | done          |
+-----------+---------------+
1 row in set (0.001 sec)

MariaDB [devops_l1]> DELETE FROM devops_l1_members where member_id=1;
Query OK, 1 row affected (0.017 sec)

MariaDB [devops_l1]> SELECT * FROM devops_l1_member_status;
Empty set (0.001 sec)
```
Update row in the table

`UPDATE devops_l1_members SET submission_date = '2022.10.22' WHERE member_id = 2;`

```
MariaDB [devops_l1]> SELECT * FROM devops_l1_members;
+-----------+-------------+-----------------+-----------------+
| member_id | member_name | member_location | submission_date |
+-----------+-------------+-----------------+-----------------+
|         2 | Vlad        | Dnipro          | 2022-10-22      |
+-----------+-------------+-----------------+-----------------+
```
**Create a user with different privileges**

`CREATE USER 'devops'@'localhost' IDENTIFIED BY 'password@123';`
`GRANT CREATE, UPDATE, SELECT on devops_l1.* TO devops@localhost;`
`FLUSH PRIVILEGES;`

```
MariaDB [devops_l1]> SHOW GRANTS FOR 'devops'@localhost;
+---------------------------------------------------------------------------------------------------------------+
| Grants for devops@localhost                                                                                   |
+---------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `devops`@`localhost` IDENTIFIED BY PASSWORD '*678E2A46B8C71291A3915F92736C080819AD76DF' |
| GRANT SELECT, UPDATE, CREATE ON `devops_l1`.* TO `devops`@`localhost`                                         |
+---------------------------------------------------------------------------------------------------------------+
```
Check permissions under the created user

```
mysql -u devops -p
Enter password:

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| devops_l1          |
| information_schema |
+--------------------+
2 rows in set (0.005 sec)

MariaDB [(none)]> use devops_l1;
Database changed
MariaDB [devops_l1]> show tables;
+-------------------------+
| Tables_in_devops_l1     |
+-------------------------+
| devops_l1_member_status |
| devops_l1_members       |
| devops_l1_tasks         |
+-------------------------+
3 rows in set (0.002 sec)

MariaDB [devops_l1]> describe devops_l1_members;
+-----------------+--------------+------+-----+---------+----------------+
| Field           | Type         | Null | Key | Default | Extra          |
+-----------------+--------------+------+-----+---------+----------------+
| member_id       | int(11)      | NO   | PRI | NULL    | auto_increment |
| member_name     | varchar(100) | NO   |     | NULL    |                |
| member_location | varchar(40)  | NO   |     | NULL    |                |
| submission_date | date         | YES  |     | NULL    |                |
+-----------------+--------------+------+-----+---------+----------------+
4 rows in set (0.004 sec)

MariaDB [devops_l1]> ALTER TABLE devops_l1_members ADD COLUMN member_surname varchar(40) NOT NULL;
ERROR 1142 (42000): ALTER command denied to user 'devops'@'localhost' for table 'devops_l1_members'
```
**Create a database backup**

`mysqldump -u root -p devops_l1 > mydbscheme_dump.sql`

Remove one table

```
DROP TABLE devops_l1_member_status;
Query OK, 0 rows affected (0.039 sec)

MariaDB [devops_l1]> show tables;
+---------------------+
| Tables_in_devops_l1 |
+---------------------+
| devops_l1_members   |
| devops_l1_tasks     |
+---------------------+
```

**Restore the table from the backup**

`mysql -u root -p devops_l1 < mydbscheme_dump.sql`

```
show tables;
+-------------------------+
| Tables_in_devops_l1     |
+-------------------------+
| devops_l1_member_status |
| devops_l1_members       |
| devops_l1_tasks         |
+-------------------------+

MariaDB [devops_l1]> select * from devops_l1_member_status;
+-----------+---------------+
| member_id | member_status |
+-----------+---------------+
|         2 | in_progress   |
|         3 | failed        |
|         4 | done          |
+-----------+---------------+
```
