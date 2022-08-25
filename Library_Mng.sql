USE [master]
GO
/****** Object:  Database [Library_Management]    Script Date: 8/26/2022 1:31:19 AM ******/
CREATE DATABASE [Library_Management]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library_Management', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Library_Management.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Library_Management_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Library_Management_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Library_Management] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library_Management].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library_Management] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Library_Management] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Library_Management] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Library_Management] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Library_Management] SET ARITHABORT OFF 
GO
ALTER DATABASE [Library_Management] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Library_Management] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Library_Management] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Library_Management] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Library_Management] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Library_Management] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Library_Management] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Library_Management] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Library_Management] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Library_Management] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Library_Management] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Library_Management] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Library_Management] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Library_Management] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Library_Management] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Library_Management] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Library_Management] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Library_Management] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Library_Management] SET  MULTI_USER 
GO
ALTER DATABASE [Library_Management] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Library_Management] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Library_Management] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Library_Management] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Library_Management] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Library_Management] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Library_Management] SET QUERY_STORE = OFF
GO
USE [Library_Management]
GO
/****** Object:  Table [dbo].[UserVisited]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserVisited](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Identity_Card] [int] NOT NULL,
	[Role] [nvarchar](200) NULL,
	[Date_In] [datetime] NOT NULL,
	[Date_Out] [datetime] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[Book_ID] [int] IDENTITY(1,1) NOT NULL,
	[Book_Name] [nvarchar](500) NOT NULL,
	[Book_Author] [nvarchar](200) NULL,
	[Page] [int] NULL,
	[Language] [nvarchar](100) NULL,
	[Publish_Date] [date] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[Book_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Librarian]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Librarian](
	[Li_ID] [int] IDENTITY(1,1) NOT NULL,
	[Li_Name] [nvarchar](300) NOT NULL,
	[Li_Gender] [nvarchar](100) NOT NULL,
	[Li_DoB] [date] NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Libraian] PRIMARY KEY CLUSTERED 
(
	[Li_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Borrow]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Borrow](
	[Borrow_ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Book_ID] [int] NOT NULL,
	[Li_ID] [int] NOT NULL,
	[Borrow_Date] [date] NOT NULL,
	[Duration] [int] NOT NULL,
	[Return_Date] [date] NOT NULL,
	[Status] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Borrow] PRIMARY KEY CLUSTERED 
(
	[Borrow_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_seacherBorrower]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_seacherBorrower](@Identity_Card int, @status varchar(100))
returns table
as 
return(
		select u.Identity_Card, 
		bk.Book_Name, 
		li.Li_Name, 
		b.Borrow_Date,
		b.Duration,
		b.Return_Date,
		b.Status,
		b.Description
		from Borrow b  inner join UserVisited u on b.UserID = u.UserID 
		inner join Book bk on b.Book_ID = bk.Book_ID inner join Librarian li on b.Li_ID = li.Li_ID
		where u.Identity_Card = @Identity_Card AND  b.Status = @status
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_searchBook]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_searchBook](@Book_Name nvarchar(300))
returns table
as 
return(
	select * from Book where Book.Book_Name = @Book_Name
)
GO
/****** Object:  Table [dbo].[Login]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login](
	[Login_ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](200) NOT NULL,
	[Password] [nvarchar](200) NOT NULL,
	[Role] [nvarchar](100) NOT NULL,
	[Status] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[Login_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD  CONSTRAINT [FK_Borrow_Book] FOREIGN KEY([Book_ID])
REFERENCES [dbo].[Book] ([Book_ID])
GO
ALTER TABLE [dbo].[Borrow] CHECK CONSTRAINT [FK_Borrow_Book]
GO
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD  CONSTRAINT [FK_Borrow_Librarian] FOREIGN KEY([Li_ID])
REFERENCES [dbo].[Librarian] ([Li_ID])
GO
ALTER TABLE [dbo].[Borrow] CHECK CONSTRAINT [FK_Borrow_Librarian]
GO
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD  CONSTRAINT [FK_Borrow_UserVisited] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserVisited] ([UserID])
GO
ALTER TABLE [dbo].[Borrow] CHECK CONSTRAINT [FK_Borrow_UserVisited]
GO
/****** Object:  StoredProcedure [dbo].[sp_Brrower]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_Brrower](
@UserID int,
@BookID int,
@Li_ID int,
@Borrow_Date date,
@Duration int,
@Return_Date date,
@Status nvarchar(100), 
@Description nvarchar(max)
)
as
begin
	insert into Borrow(UserID, Book_ID, Li_ID, Borrow_Date,Duration, Return_Date, Status, Description)
	values(@UserID, @BookID, @Li_ID, @Borrow_Date, @Duration, @Return_Date, @Status, @Description)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_createLibrarian]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_createLibrarian](
@Li_Name nvarchar(300), 
@Li_Gender nvarchar(100),
@Li_DoB date,
@Description nvarchar(max)=null
)
as
begin
 insert into Librarian(Li_Name, Li_Gender, Li_DoB, Description)
 values(@Li_Name, @Li_Gender, @Li_DoB, @Description)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_updateAllBorrowing]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_updateAllBorrowing](@Identiy_Card int)
as
begin
	-- update all borrowing status to returned
	update Borrow set Borrow.Status = 'Borrowing' from  Borrow b  inner join UserVisited u on b.UserID = u.UserID 
	where u.Identity_Card = @Identiy_Card AND  b.Status = 'Returned'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_updateSpecificBorrower]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_updateSpecificBorrower](@Identiy_Card int, @Book_Name nvarchar(300))
as
begin
	-- update with specific book name
	update Borrow set Borrow.Status = 'Returned' from  Borrow b  inner join UserVisited u on b.UserID = u.UserID 
	inner join Book bk on bk.Book_ID = b.Book_ID
	where u.Identity_Card = @Identiy_Card AND  b.Status = 'Borrowing' AND bk.Book_Name = @Book_Name
end
GO
/****** Object:  StoredProcedure [dbo].[sq_addBook]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sq_addBook](
@Book_Name nvarchar(500),
@Book_Author nvarchar(500),
@Page int,
@Language nvarchar(100),
@Publich_Date date,
@Description nvarchar(max)
)
as
begin 
insert into Book(Book_Name, Book_Author, Page, Language, Publish_Date, Description)
values(@Book_Name, @Book_Author, @Page, @Language, @Publich_Date, @Description)
end
GO
/****** Object:  StoredProcedure [dbo].[sq_CreateLogin]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sq_CreateLogin](
@Username varchar(200),
@Password nvarchar(200),
@Role nvarchar(100),
@Status nvarchar(100))
as
begin
	insert into Login(Username,Password,Role,Status)
	values( @Username, @Password, @Role, @Status)
end
GO
/****** Object:  StoredProcedure [dbo].[sq_createUser]    Script Date: 8/26/2022 1:31:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sq_createUser](
@Identity_Card int,
@Role nvarchar(200),
@Date_In datetime,
@Date_Out datetime
)
as
begin
	insert into UserVisited(Identity_Card,Role,Date_In,Date_Out) 
	values(@Identity_Card, @Role, @Date_In, @Date_Out)
end
GO
USE [master]
GO
ALTER DATABASE [Library_Management] SET  READ_WRITE 
GO
