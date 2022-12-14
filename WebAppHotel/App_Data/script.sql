USE [master]
GO
/****** Object:  Database [HotelDB]    Script Date: 1.10.2022 22:00:03 ******/
CREATE DATABASE [HotelDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HotelDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\HotelDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HotelDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\HotelDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [HotelDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HotelDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HotelDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HotelDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HotelDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HotelDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HotelDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [HotelDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HotelDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HotelDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HotelDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HotelDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HotelDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HotelDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HotelDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HotelDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HotelDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HotelDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HotelDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HotelDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HotelDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HotelDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HotelDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HotelDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HotelDB] SET RECOVERY FULL 
GO
ALTER DATABASE [HotelDB] SET  MULTI_USER 
GO
ALTER DATABASE [HotelDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HotelDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HotelDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HotelDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HotelDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HotelDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HotelDB', N'ON'
GO
ALTER DATABASE [HotelDB] SET QUERY_STORE = OFF
GO
USE [HotelDB]
GO
/****** Object:  Schema [Booking]    Script Date: 1.10.2022 22:00:04 ******/
CREATE SCHEMA [Booking]
GO
/****** Object:  Schema [Hotel]    Script Date: 1.10.2022 22:00:04 ******/
CREATE SCHEMA [Hotel]
GO
/****** Object:  Schema [Master]    Script Date: 1.10.2022 22:00:04 ******/
CREATE SCHEMA [Master]
GO
/****** Object:  Table [Hotel].[Payments]    Script Date: 1.10.2022 22:00:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Hotel].[Payments](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[BookingId] [int] NOT NULL,
	[PaymentTypeId] [int] NOT NULL,
	[PaymentAmount] [decimal](18, 2) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Hotel].[RoomBookings]    Script Date: 1.10.2022 22:00:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Hotel].[RoomBookings](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](500) NOT NULL,
	[CustomerAddress] [nvarchar](550) NOT NULL,
	[CustomerPhone] [varchar](50) NOT NULL,
	[BookingFrom] [date] NOT NULL,
	[BookingTo] [date] NOT NULL,
	[AssingRoomId] [int] NOT NULL,
	[NoOfMembers] [int] NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_RoomBookings] PRIMARY KEY CLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Hotel].[Rooms]    Script Date: 1.10.2022 22:00:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Hotel].[Rooms](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[RoomNumber] [nvarchar](50) NOT NULL,
	[RoomImage] [nvarchar](50) NOT NULL,
	[RoomPrice] [decimal](18, 2) NOT NULL,
	[BookStatusId] [int] NOT NULL,
	[RoomTypeId] [int] NOT NULL,
	[RoomCapacity] [int] NOT NULL,
	[RoomDescription] [nvarchar](550) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Rooms] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Master].[BookingStatus]    Script Date: 1.10.2022 22:00:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Master].[BookingStatus](
	[BookingStatusId] [int] IDENTITY(1,1) NOT NULL,
	[BookingStatus] [varchar](50) NOT NULL,
 CONSTRAINT [PK_BookingStatus] PRIMARY KEY CLUSTERED 
(
	[BookingStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Master].[PaymentTypes]    Script Date: 1.10.2022 22:00:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Master].[PaymentTypes](
	[PaymentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[PaymentType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PaymentTypes] PRIMARY KEY CLUSTERED 
(
	[PaymentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Master].[RoomTypes]    Script Date: 1.10.2022 22:00:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Master].[RoomTypes](
	[RoomTypeID] [int] IDENTITY(1,1) NOT NULL,
	[RoomTypeName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_RoomTypes] PRIMARY KEY CLUSTERED 
(
	[RoomTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [Hotel].[Rooms] ON 

INSERT [Hotel].[Rooms] ([RoomId], [RoomNumber], [RoomImage], [RoomPrice], [BookStatusId], [RoomTypeId], [RoomCapacity], [RoomDescription], [IsActive]) VALUES (1, N'101', N'61a1d955-b97f-48a2-8e88-0f927b82e45a.jpg', CAST(45000.00 AS Decimal(18, 2)), 2, 1, 2, N'Room İs good!!!', 1)
INSERT [Hotel].[Rooms] ([RoomId], [RoomNumber], [RoomImage], [RoomPrice], [BookStatusId], [RoomTypeId], [RoomCapacity], [RoomDescription], [IsActive]) VALUES (2, N'102', N'078476a2-144b-4349-97a9-f2d58735eb19.jpg', CAST(560000.00 AS Decimal(18, 2)), 3, 3, 1, N'Room is very well', 1)
INSERT [Hotel].[Rooms] ([RoomId], [RoomNumber], [RoomImage], [RoomPrice], [BookStatusId], [RoomTypeId], [RoomCapacity], [RoomDescription], [IsActive]) VALUES (3, N'103', N'811cfad3-6c90-435e-816d-24aee415b405.jpeg', CAST(7500.00 AS Decimal(18, 2)), 2, 3, 2, N'Room is Suite', 1)
INSERT [Hotel].[Rooms] ([RoomId], [RoomNumber], [RoomImage], [RoomPrice], [BookStatusId], [RoomTypeId], [RoomCapacity], [RoomDescription], [IsActive]) VALUES (4, N'104', N'45b2d7d8-f37f-4a76-86cd-38884fc6cce0.jpg', CAST(8500.00 AS Decimal(18, 2)), 1, 4, 3, N'Room is Duplex', 1)
INSERT [Hotel].[Rooms] ([RoomId], [RoomNumber], [RoomImage], [RoomPrice], [BookStatusId], [RoomTypeId], [RoomCapacity], [RoomDescription], [IsActive]) VALUES (5, N'105', N'c378c4a7-2aee-458e-bbe0-ad17a4212b81.jpg', CAST(23.00 AS Decimal(18, 2)), 2, 3, 23, N'23', 1)
INSERT [Hotel].[Rooms] ([RoomId], [RoomNumber], [RoomImage], [RoomPrice], [BookStatusId], [RoomTypeId], [RoomCapacity], [RoomDescription], [IsActive]) VALUES (6, N'106', N'd1a9c8e8-33de-43a7-a540-b2ddb3dbba5c.jpeg', CAST(2500.00 AS Decimal(18, 2)), 1, 1, 1, N'gooddd', 1)
SET IDENTITY_INSERT [Hotel].[Rooms] OFF
GO
SET IDENTITY_INSERT [Master].[BookingStatus] ON 

INSERT [Master].[BookingStatus] ([BookingStatusId], [BookingStatus]) VALUES (1, N'Rezerved')
INSERT [Master].[BookingStatus] ([BookingStatusId], [BookingStatus]) VALUES (2, N'Free')
INSERT [Master].[BookingStatus] ([BookingStatusId], [BookingStatus]) VALUES (3, N'Occupied')
SET IDENTITY_INSERT [Master].[BookingStatus] OFF
GO
SET IDENTITY_INSERT [Master].[PaymentTypes] ON 

INSERT [Master].[PaymentTypes] ([PaymentTypeId], [PaymentType]) VALUES (1, N'Cash')
INSERT [Master].[PaymentTypes] ([PaymentTypeId], [PaymentType]) VALUES (2, N'Credit Card')
INSERT [Master].[PaymentTypes] ([PaymentTypeId], [PaymentType]) VALUES (3, N'Debit Card')
INSERT [Master].[PaymentTypes] ([PaymentTypeId], [PaymentType]) VALUES (4, N'Online Transaction')
SET IDENTITY_INSERT [Master].[PaymentTypes] OFF
GO
SET IDENTITY_INSERT [Master].[RoomTypes] ON 

INSERT [Master].[RoomTypes] ([RoomTypeID], [RoomTypeName]) VALUES (1, N'Single')
INSERT [Master].[RoomTypes] ([RoomTypeID], [RoomTypeName]) VALUES (2, N'Double')
INSERT [Master].[RoomTypes] ([RoomTypeID], [RoomTypeName]) VALUES (3, N'Suite')
INSERT [Master].[RoomTypes] ([RoomTypeID], [RoomTypeName]) VALUES (4, N'Duplex')
SET IDENTITY_INSERT [Master].[RoomTypes] OFF
GO
USE [master]
GO
ALTER DATABASE [HotelDB] SET  READ_WRITE 
GO
