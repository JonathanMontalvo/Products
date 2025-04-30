DESKTOP-0SKCN4Q
CREATE DATABASE Practice;
USE Practice;
GO

-- Tabla Categories
CREATE TABLE Categories (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Active BIT NOT NULL
);

-- Tabla Products
CREATE TABLE Products (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    Category_Id INT NOT NULL,
    Active BIT NOT NULL,
    CONSTRAINT FK_Products_Categories
    FOREIGN KEY (Category_Id)
    REFERENCES Categories(Id)
);
ALTER TABLE Products
ADD CONSTRAINT Check_Products_Price
CHECK (Price > 0);

-- Tabla Employees
CREATE TABLE Employees (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Lastname NVARCHAR(100) NOT NULL,
    Registration_Date DATE NOT NULL,
    Active BIT NOT NULL
);

-- Tabla Orders
CREATE TABLE Orders (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Order_Date DATE NOT NULL,
    Total INT NOT NULL,
    Employee_Id INT NOT NULL,
    Active BIT NOT NULL,
    CONSTRAINT FK_Orders_Employees
    FOREIGN KEY (Employee_Id)
    REFERENCES Employees(Id)
);
ALTER TABLE Orders
ADD CONSTRAINT Check_Orders_Total
CHECK (Total > 0);

-- Tabla Orders_Products
CREATE TABLE Orders_Products (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Order_Id INT NOT NULL,
    Product_Id INT NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT FK_OP_Orders
    FOREIGN KEY (Order_Id)
    REFERENCES Orders(Id),
    CONSTRAINT FK_OP_Products
    FOREIGN KEY (Product_Id)
    REFERENCES Products(Id)
);
ALTER TABLE Orders_Products
ADD CONSTRAINT Check_OP_Quantity
CHECK (Quantity > 0);
