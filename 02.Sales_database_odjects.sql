USE [Sales]
GO
/****** Object:  UserDefinedTableType [dbo].[PriceTableType]    Script Date: 17.10.2017 15:55:05 ******/
CREATE TYPE [dbo].[PriceTableType] AS TABLE(
	[ProductID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL
)
GO
/****** Object:  Table [dbo].[City]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ChangeDate] [datetime2](0) NOT NULL,
	[ChangedUser] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Price]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Price](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ChangeDate] [datetime2](0) NOT NULL,
	[ChangedUser] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Price] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductTypeID] [int] NOT NULL,
	[ProuuctName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ChangeDate] [datetime2](0) NOT NULL,
	[ChangedUser] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductType] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ChangeDate] [datetime2](0) NOT NULL,
	[ChangedUser] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Stores]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CityID] [int] NOT NULL,
	[StoreName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ChangeDate] [datetime2](0) NOT NULL,
	[ChangedUser] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Stores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[vCity]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vCity]
	AS 
SELECT c.Id, c.CityName 
FROM City c
WHERE c.IsActive = 1

GO
/****** Object:  View [dbo].[vPrice]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vPrice]
	AS 
SELECT p.ProductID, pr.ProuuctName, p.StoreID, s.StoreName, p.Id, p.Price
FROM Price p
JOIN Products pr ON pr.Id = p.ProductID
JOIN Stores s ON s.Id = p.StoreID
WHERE p.IsActive = 1

GO
/****** Object:  View [dbo].[vProducts]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vProducts]
	AS 
SELECT pr.Id, pr.ProuuctName, pr.ProductTypeID, pt.ProductType
FROM Products pr
JOIN ProductType pt ON pt.Id = pr.ProductTypeID
WHERE pr.IsActive = 1

GO
/****** Object:  View [dbo].[vProductType]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vProductType]
	AS 
SELECT pt.Id, pt.ProductType 
FROM ProductType pt
WHERE pt.IsActive = 1

GO
/****** Object:  View [dbo].[vStores]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vStores]
	AS 
SELECT s.Id, s.StoreName, s.CityID, c.CityName 
FROM Stores s
JOIN City c ON c.Id = s.CityID 
WHERE s.IsActive = 1

GO
ALTER TABLE [dbo].[City] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT (getdate()) FOR [ChangeDate]
GO
ALTER TABLE [dbo].[City] ADD  DEFAULT (suser_sname()) FOR [ChangedUser]
GO
ALTER TABLE [dbo].[Price] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Price] ADD  DEFAULT (getdate()) FOR [ChangeDate]
GO
ALTER TABLE [dbo].[Price] ADD  DEFAULT (suser_sname()) FOR [ChangedUser]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [ChangeDate]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (suser_sname()) FOR [ChangedUser]
GO
ALTER TABLE [dbo].[ProductType] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ProductType] ADD  DEFAULT (getdate()) FOR [ChangeDate]
GO
ALTER TABLE [dbo].[ProductType] ADD  DEFAULT (suser_sname()) FOR [ChangedUser]
GO
ALTER TABLE [dbo].[Stores] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Stores] ADD  DEFAULT (getdate()) FOR [ChangeDate]
GO
ALTER TABLE [dbo].[Stores] ADD  DEFAULT (suser_sname()) FOR [ChangedUser]
GO
ALTER TABLE [dbo].[Price]  WITH CHECK ADD  CONSTRAINT [FK_Price_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Price] CHECK CONSTRAINT [FK_Price_Products]
GO
ALTER TABLE [dbo].[Price]  WITH CHECK ADD  CONSTRAINT [FK_Price_Stores] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([Id])
GO
ALTER TABLE [dbo].[Price] CHECK CONSTRAINT [FK_Price_Stores]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_ProductType] FOREIGN KEY([ProductTypeID])
REFERENCES [dbo].[ProductType] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_ProductType]
GO
ALTER TABLE [dbo].[Stores]  WITH CHECK ADD  CONSTRAINT [FK_Stores_City] FOREIGN KEY([CityID])
REFERENCES [dbo].[City] ([Id])
GO
ALTER TABLE [dbo].[Stores] CHECK CONSTRAINT [FK_Stores_City]
GO
/****** Object:  StoredProcedure [dbo].[procAddCity]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procAddCity]
	@City NVARCHAR(100)
AS
BEGIN
	INSERT INTO City (CityName)
	VALUES (@City)
END

GO
/****** Object:  StoredProcedure [dbo].[procAddOrChangePrice]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[procAddOrChangePrice]
	@Prices PriceTableType READONLY
AS
BEGIN
	IF (EXISTS (SELECT 1 FROM @Prices WHERE Price = 0))
		THROW 51003, 'Price can not be equal 0!', 1
	ELSE
	BEGIN
		UPDATE p
		SET p.IsActive = 0
		FROM Price p
		JOIN @Prices pr ON pr.Price = p.Price
			AND pr.ProductID =  p.ProductId
			AND pr.StoreID = p.StoreID
			AND p.IsActive = 1

		INSERT INTO Price (ProductId, StoreID, Price)
		SELECT ProductID, StoreID, Price FROM @Prices
	END
END


GO
/****** Object:  StoredProcedure [dbo].[procAddProduct]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procAddProduct]
	@ProductName NVARCHAR(100), @ProductTypeID INT
AS
BEGIN
	IF (REPLACE(@ProductName,' ','') != '')
		INSERT INTO Products (ProuuctName, ProductTypeID)
		VALUES (@ProductName, @ProductTypeID)
	ELSE
		THROW 51001, 'Product name can not be empty!', 1	
END

GO
/****** Object:  StoredProcedure [dbo].[procAddProductType]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procAddProductType]
	@ProductType NVARCHAR(100)
AS
BEGIN
	INSERT INTO ProductType (ProductType)
	VALUES (@ProductType)
END

GO
/****** Object:  StoredProcedure [dbo].[procAddStore]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procAddStore]
	@Store NVARCHAR(100), @CityID INT
AS
BEGIN
	IF (REPLACE(@Store,' ','') != '') 
		INSERT INTO Stores (StoreName, CityID)
		VALUES (@Store, @CityID)
	ELSE 
		THROW 51002, 'Store name can not be empty!', 1
END

GO
/****** Object:  StoredProcedure [dbo].[procChangeProduct]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procChangeProduct]
	@ProductID INT, @ProductTypeID INT, @ProductName NVARCHAR(100)
AS
BEGIN
	IF (REPLACE(@ProductName,' ','') != '')
	BEGIN
		DECLARE 
		@OldPName NVARCHAR(100),
		@OldPtype INT

		SELECT @OldPtype = p.ProductTypeID, @OldPName = p.ProuuctName
		FROM Products p
		WHERE p.Id = @ProductID

		IF ((@ProductTypeID <> @OldPtype) OR (@ProductName <> @OldPName))
		UPDATE Products
		SET ProductTypeID = @ProductTypeID,
			ProuuctName = @ProductName
		WHERE id = @ProductID
	END
	ELSE
		THROW 51001, 'Product name can not be empty!', 1
END

GO
/****** Object:  StoredProcedure [dbo].[procChangeStore]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procChangeStore]
	@StoreID INT, @CityID INT, @StoreName NVARCHAR(100)
AS
BEGIN
IF (REPLACE(@StoreName,' ','') != '') 
	BEGIN
		DECLARE 
			@OldSName NVARCHAR(100),
			@OldSCity INT

		SELECT @OldSCity = s.CityID, @OldSName = s.StoreName
		FROM Stores s
		WHERE s.Id = @StoreID

		IF ((@CityID <> @OldSCity) OR (@StoreName <> @OldSName))
		UPDATE Stores
		SET CityID = @CityID,
			StoreName = @StoreName
		WHERE id = @StoreID
	END
	ELSE
		THROW 51002, 'Store name can not be empty!', 1
END

GO
/****** Object:  StoredProcedure [dbo].[procDeleteCity]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procDeleteCity]
	@CityID INT
AS
BEGIN

	SET NoCount ON;

	UPDATE City
	SET IsActive = 0
	WHERE Id = @CityID

END;

GO
/****** Object:  StoredProcedure [dbo].[procDeletePrice]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procDeletePrice]
	@PriceID INT
AS
BEGIN
	UPDATE Price
	SET IsActive = 0
	WHERE Id = @PriceID
END

GO
/****** Object:  StoredProcedure [dbo].[procDeleteProduct]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procDeleteProduct]
	@ProductID INT
AS
BEGIN

	UPDATE Products
	SET IsActive = 0
	WHERE Id = @ProductID

END

GO
/****** Object:  StoredProcedure [dbo].[procDeleteProductType]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procDeleteProductType]
	@ProductTypeID INT
AS
BEGIN

	SET NoCount ON;

	UPDATE ProductType
	SET IsActive = 0
	WHERE Id = @ProductTypeID

END;

GO
/****** Object:  StoredProcedure [dbo].[procDeleteStore]    Script Date: 17.10.2017 15:55:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procDeleteStore]
	@StoreID INT
AS
BEGIN

	UPDATE Stores
	SET IsActive = 0
	WHERE Id = @StoreID

END;

GO
