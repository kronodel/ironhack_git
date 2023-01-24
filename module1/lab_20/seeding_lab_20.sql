-- Challenge 3 - Seeding the Database --

use lab_mysql;

INSERT INTO cars (ID, VIN, Manufacturer, Model, Year, Color)
VALUES (0, '3K096I98581DHSNUP', 'Volkswagen', 'Tiguan', 2019, 'Blue'),
(1, 'ZM8G7BEUQZ97IH46V', 'Peugeot', 'Rifter', 2019, 'Red');


INSERT INTO Customers (ID, Name, Phone_number, Email, Address, City, State_Province, Country, Zip_Postal_code)
VALUES (0, 'Pablo Picasso', '+34 636 17 63 82', '-', 'Paseo de la Chopera, 14', 'Madrid', 'Madrid', 'Spain', '28045'),
       (1, 'Abraham Lincoln', '+1 305 907 7086', '-', '120 SW 8th St', 'Miami', 'Florida', 'United States', '33130'),
       (2, 'Napoleon Bonaparte', '+33 1 79 75 40 00', '-', '40 Rue du Colisée', 'Paris', 'Île-de-France', 'France', '75008');

INSERT INTO Salespersons (ID, Staff_ID, Name, Store)
VALUES (0, 00001, 'Petey Cruiser', 'Madrid'),
       (1, 00002, 'Anna Sthesia', 'Barcelona'),
       (2, 00003, 'Paul Molive', 'Berlin'),
       (3, 00004, 'Gail Forcewind', 'Paris'),
       (4, 00005, 'Paige Turner', 'Mimia'),
       (5, 00006, 'Bob Frapples', 'Mexico City'),
       (6, 00007, 'Walter Melon', 'Amsterdam'),
       (7, 00008, 'Shonda Leer', 'São Paulo');
       
INSERT INTO Invoices (ID, Invoice_number, Date, Car, Customer, Salesperson)
VALUES (0, 852399038, '22-08-2018', 0, 1, 3),
       (1, 731166526, '31-12-2018', 3, 0, 5),
       (2, 271135104, '22-01-2019', 2, 2, 7);

