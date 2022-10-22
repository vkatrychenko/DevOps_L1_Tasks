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


