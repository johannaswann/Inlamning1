-- Skapar databasen för en liten bokhandel
CREATE DATABASE Bokhandel;
USE Bokhandel; -- Använda databasen
 
 -- Skapar kundtabellen 
CREATE TABLE Kunder (
KundID INT AUTO_INCREMENT PRIMARY KEY, -- Varje kund får ett unikt KundID 
Namn VARCHAR(100) NOT NULL, -- Varje kund måste ha ett namn och kan inte lämnas tomt
Email VARCHAR(255) UNIQUE NOT NULL, -- Måste finnas en unik email för varje kund
Telefon VARCHAR(50), -- Telefon är frivilligt att registrera
Adress VARCHAR(255)
);

-- Skapar tabellen för böcker
CREATE TABLE Bocker (
BokID INT AUTO_INCREMENT PRIMARY KEY,
Titel VARCHAR(255) NOT NULL,
ISBN VARCHAR(50) UNIQUE NOT NULL,
Forfattare VARCHAR(255) NOT NULL,
Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0), -- Pris måste anges och vara större än 0
Lagerstatus INT NOT NULL
);

-- Skapar tabellen för beställningar
CREATE TABLE Bestallningar (
OrderID INT AUTO_INCREMENT PRIMARY KEY,
KundID INT NOT NULL,    -- En beställning måste tillhöra en kund
Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Tilldelas datum och tid automatiskt
Totalbelopp DECIMAL(10,2) NOT NULL,
FOREIGN KEY (KundID) REFERENCES Kunder (KundID) -- Lånar PK från Kunder (KundID)
);

-- Skapar tabellen för orderrader
CREATE TABLE Orderrader (
Orderrader INT AUTO_INCREMENT PRIMARY KEY,
BokID INT NOT NULL,
OrderID INT NOT NULL, 
Antal INT NOT NULL CHECK (Antal > 0),
Styckepris DECIMAL(10,2) NOT NULL,
FOREIGN KEY (BokID) REFERENCES Bocker (BokID), -- Lånar PK nycklen från Böcker (BokID)
FOREIGN KEY (OrderID) REFERENCES Bestallningar (OrderID) -- Lånar PK nycklen från Beställningar (OrderID)
);

-- Infogar data i kunder
INSERT INTO Kunder (Namn, Email) VALUES
('Jon Snow', 'jon@email.com'),
('Arya Stark', 'arya@email.com'),
('Tyrion Lannister', 'tyrion@email.com');

-- Infogar data i böcker
INSERT INTO Bocker (Titel, BokID, ISBN, Forfattare, Pris, Lagerstatus) VALUES
('A Song of Ice and Fire', '5585', '95-646-75-87', 'Sam Thompson', 399.00, 8),
('A Dance with Dragons', '5586', '45-646-35-86', 'Adam Holmshaw', 199.00, 10),
('A Clash of Kings', '5587', '25-456-35-85', 'Rosie Murphy', 299.00, 6);

-- Infogar data i beställningar
INSERT INTO Bestallningar (KundID, Datum, Totalbelopp) VALUE
(1, '2024-10-15', 399.00), -- Jon koper 1 bocker
(2, '2024-10-02', 598.00), -- Arya koper 2 bocker
(3, '2024-09-28', 299.00); -- Tyrion koper 1 bok

-- Infogar data i orderrader
INSERT INTO Orderrader (OrderID, BokID, Antal, Styckepris) VALUES
(1, '5585', 1, 399.00);

-- Infogar data i orderrader
INSERT INTO Orderrader (OrderID, BokID, Antal, Styckepris) VALUES
(2, '5585', 1, 399.00),
(2, '5586', 1, 199.00);

-- Infogar data i orderrader
INSERT INTO Orderrader (OrderID, BokID, Antal, Styckepris) VALUES
(3, '5587', 1, 299.00);

-- Hämtar data från de olika tabellerna
SELECT * FROM Bocker;
SELECT * FROM Kunder;
SELECT * FROM Bestallningar;
SELECT * FROM Orderrader;