-- Customers
CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT,
    LastName TEXT,
    Age INTEGER,
    Gender TEXT,
    Income REAL,
    Email TEXT,
    Phone TEXT,
    Address TEXT
);

-- Products
CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductName TEXT,
    Price REAL,
    Category TEXT,
    StockQuantity INTEGER,
    Description TEXT
);

-- Sales
CREATE TABLE Sales (
    SaleID INTEGER PRIMARY KEY AUTOINCREMENT,
    CustomerID INTEGER,
    ProductID INTEGER,
    Quantity INTEGER,
    SaleAmount REAL,
    SaleDate TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Orders
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY AUTOINCREMENT,
    CustomerID INTEGER NOT NULL,
    OrderDate TEXT NOT NULL,
    TotalAmount REAL NOT NULL,
    ShippingAddress TEXT NOT NULL,
    OrderStatus TEXT NOT NULL,
    PaymentMethod TEXT NOT NULL,
    LastUpdated TEXT DEFAULT CURRENT_TIMESTAMP,
    ShippingDate TEXT,
    ProductID INTEGER NOT NULL,
    Quantity INTEGER NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Customers
INSERT INTO Customers (FirstName, LastName, Age, Gender, Income, Email, Phone, Address)
VALUES 
('Ahmet', 'Yılmaz', 30, 'Erkek', 50000.00, 'ahmet@example.com', '5551234567', 'İstanbul, Türkiye'),
('Ayşe', 'Kaya', 28, 'Kadın', 45000.00, 'ayse@example.com', '5552345678', 'Ankara, Türkiye'),
('Mustafa', 'Çelik', 50, 'Erkek', 75000.00, 'mustafa@example.com', '5557845678', 'Hatay, Türkiye'),
('Mehmet', 'Demir', 35, 'Erkek', 60000.00, 'mehmet@example.com', '5553456789', 'İzmir, Türkiye');

-- Products
INSERT INTO Products (ProductName, Price, Category, StockQuantity, Description)
VALUES 
('Smartphone', 1500.00, 'Elektronik', 50, 'Yüksek çözünürlüklü ekran, 64GB depolama alanı'),
('T-shirt', 100.00, 'Giyim', 200, 'Pamuklu, rahat kullanım'),
('Laptop', 3500.00, 'Elektronik', 30, 'Intel i7 işlemci, 16GB RAM, 512GB SSD');

-- Sales
INSERT INTO Sales (CustomerID, ProductID, Quantity, SaleAmount, SaleDate)
VALUES 
(1, 1, 1, 1500.00, '2024-12-25 10:30:00'),
(2, 2, 2, 200.00, '2024-12-26 14:15:00'),
(3, 3, 1, 3500.00, '2024-12-27 16:00:00');

-- Orders
INSERT INTO Orders 
(CustomerID, OrderDate, TotalAmount, ShippingAddress, OrderStatus, PaymentMethod, ShippingDate, ProductID, Quantity)
VALUES
(1, '2024-12-26 10:00:00', 5000.00, 'İstanbul, Türkiye', 'Beklemede', 'Kredi Kartı', '2024-12-26 09:00:00', 1, 1),
(2, '2024-12-25 14:30:00', 1500.00, 'Ankara, Türkiye', 'Tamamlandı', 'Havale', '2024-12-26 09:00:00', 2, 1),
(1, '2024-12-26 12:00:00', 100.00, 'İstanbul, Türkiye', 'Tamamlandı', 'Kredi Kartı', '2024-12-27 10:00:00', 3, 2);








