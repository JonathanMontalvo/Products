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
    Total DECIMAL(18, 2) NOT NULL,
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
    Active BIT NOT NULL,
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

SELECT O.Id, E.Name, E.Lastname, O.Total
FROM Orders O
INNER JOIN Employees E ON O.Employee_Id = E.Id;

SELECT OP.Id, OP.Order_Id, P.Name, C.Name, OP.Quantity, P.Price, (OP.Quantity * P.Price) AS Total 
FROM Orders_Products OP
INNER JOIN Products P ON OP.Product_Id = P.Id
INNER JOIN Categories C ON P.Category_Id = C.Id
WHERE OP.Order_Id = 1;

{
  "employeeId": 2,
  "ordersProducts": [
    {
      "productId": 6,
      "quantity": 10
    }
  ],
  "total": 163.00
}


{
  "employeeId": 1,
  "ordersProducts": [
    {
      "productId": 6,
      "quantity": 10
    },
    {
      "productId": 5,
      "quantity": 5
    },
    {
      "productId": 4,
      "quantity": 1
    },
    {
      "productId": 2,
      "quantity": 4
    },
    {
      "productId": 3,
      "quantity": 3
    },
    {
      "productId": 1,
      "quantity": 7
    }
  ],
  "total": 74597.33
}