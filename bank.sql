CREATE DATABASE dhiksha_banks;
USE dhiksha_banks;

CREATE TABLE branch (
    branch_name VARCHAR(30) NOT NULL,
    branch_city VARCHAR(25),
    assets INT,
    PRIMARY KEY (branch_name)
);

CREATE TABLE bank_account (
    accno INT NOT NULL,
    branch_name VARCHAR(30),
    balance INT,
    PRIMARY KEY (accno),
    FOREIGN KEY (branch_name) REFERENCES branch(branch_name)
);

CREATE TABLE bank_customer (
    customer_name VARCHAR(20) NOT NULL,
    customer_street VARCHAR(30),
    customer_city VARCHAR(35),
    PRIMARY KEY (customer_name)
);

CREATE TABLE depositer (
    customer_name VARCHAR(20) NOT NULL,
    accno INT NOT NULL,
    PRIMARY KEY (customer_name, accno),
    FOREIGN KEY (accno) REFERENCES bank_account(accno),
    FOREIGN KEY (customer_name) REFERENCES bank_customer(customer_name)
);

CREATE TABLE loan (
    loan_number INT NOT NULL,
    branch_name VARCHAR(30),
    amount INT,
    PRIMARY KEY (loan_number),
    FOREIGN KEY (branch_name) REFERENCES branch(branch_name)
);

-- Insert data into branch
INSERT INTO branch VALUES 
('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParlimentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);

-- Insert data into bank_account
INSERT INTO bank_account VALUES
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParlimentRoad', 9000),
(5, 'SBI_Jantarmantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),
(8, 'SBI_ResidencyRoad', 4000),
(9, 'SBI_ParlimentRoad', 3000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);

-- Insert data into bank_customer
INSERT INTO bank_customer VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannergatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');

-- Insert data into depositer
INSERT INTO depositer VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikil', 9),
('Dinesh', 10),
('Nikil', 11);

-- Insert data into loan
INSERT INTO loan VALUES
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParlimentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000);

select * from branch;
select * from bank_account;
select * from bank_customer;
select * from depositer;
select * from loan;

select Branch_name, CONCAT(assets/100000,'lakhs')assets_in_lakhs
from branch;

SELECT d.customer_name
FROM depositer d
JOIN bank_account b ON d.accno = b.accno
WHERE b.branch_name = 'SBI_ResidencyRoad'
GROUP BY d.customer_name
HAVING COUNT(d.accno) >= 2;

create view sum_of_loan
as select Branch_name, SUM(Balance)
from bank_account
group by Branch_name;
select * from sum_of_loan;

 SELECT bc.customer_name, 
       CONCAT(b.balance + 1000, ' rupees') AS updated_balance
FROM bank_account b
JOIN depositer d ON b.accno = d.accno
JOIN bank_customer bc ON bc.customer_name = d.customer_name
WHERE bc.customer_city = 'Bangalore';

