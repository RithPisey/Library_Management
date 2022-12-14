USE [master]
GO
/****** Object:  Database [Library_Management]    Script Date: 9/3/2022 11:56:43 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_searchBook]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_searchBook](@query nvarchar(200))
returns @result table(
Book_Code int,
Book_Name nvarchar(500),
Book_Author nvarchar(200),
Page int,
Language nvarchar(100),
Publish_Date date,
Description nvarchar(max))
as 
begin 
	declare @que int = 0
	if(ISNUMERIC(@query) = 1)
		set @que = CAST(@query as int)
	
	insert
	@result select Book.Book_Code, Book.Book_Name, Book.Book_Author, Book.Page, Book.Language, Book.Publish_Date, Book.Description 
	from Book
	where Book.Book_Name = @query or Book.Book_Code = @que
	return
end
GO
/****** Object:  Table [dbo].[UserVisited]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserVisited](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Identity_Card] [int] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Role] [nvarchar](200) NOT NULL,
	[Date_In] [datetime] NOT NULL,
	[Date_Out] [datetime] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_fetchUserVistor]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_fetchUserVistor]()
returns table
as
return(
	select UserVisited.Identity_Card, UserVisited.Name, UserVisited.Role, UserVisited.Date_In, UserVisited.Date_Out from UserVisited
)
GO
/****** Object:  UserDefinedFunction [dbo].[fnSearchUserVisitor]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fnSearchUserVisitor](@Identity_Card nvarchar(200))
returns table
as
return(
	select  UserVisited.Identity_Card, UserVisited.Name, UserVisited.Role, UserVisited.Date_In, UserVisited.Date_Out
	from UserVisited where UserVisited.Identity_Card = CAST(@Identity_Card as int) and UserVisited.Date_Out is null
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_SearchAllUserVistor]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_SearchAllUserVistor](@Identity_Card nvarchar(200))
returns table
as
return(
	select  UserVisited.Identity_Card, UserVisited.Name, UserVisited.Role, UserVisited.Date_In, UserVisited.Date_Out
	from UserVisited where UserVisited.Identity_Card = CAST(@Identity_Card as int)
)
GO
/****** Object:  Table [dbo].[Login]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login](
	[Login_ID] [int] IDENTITY(1,1) NOT NULL,
	[Li_ID] [int] NULL,
	[Password] [nvarchar](200) NOT NULL,
	[Role] [nvarchar](100) NOT NULL,
	[Status] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[Login_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Librarian]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Librarian](
	[Li_ID] [int] IDENTITY(1001,1) NOT NULL,
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
/****** Object:  UserDefinedFunction [dbo].[fn_getLibrarain]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_getLibrarain](@Li_ID nvarchar(100))
returns table
as
return(
	select Librarian.Li_ID, Librarian.Li_Name, Librarian.Li_Gender, Librarian.Li_DoB, Librarian.Description from Librarian 
	inner join Login on Librarian.Li_ID = Login.Li_ID where Login.Li_ID = @Li_ID
)
GO
/****** Object:  Table [dbo].[Borrow]    Script Date: 9/3/2022 11:56:43 PM ******/
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
/****** Object:  Table [dbo].[Book]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[Book_ID] [int] IDENTITY(1,1) NOT NULL,
	[Book_Code] [int] NOT NULL,
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
/****** Object:  UserDefinedFunction [dbo].[fn_fetchBorrower]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_fetchBorrower]()
returns table
as
return(
	select
	UserVisited.Identity_Card, 
	UserVisited.Name, 
	Librarian.Li_Name,
	Book.Book_Code,
	Book.Book_Name,
	Borrow.Borrow_Date,
	Borrow.Duration,
	Borrow.Return_Date,
	Borrow.Status,
	Borrow.Description
	from 
	Borrow inner join Librarian on Borrow.Li_ID = Librarian.Li_ID 
	inner join UserVisited on Borrow.UserID = UserVisited.UserID
	inner join Book on Book.Book_ID = Borrow.Book_ID
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_seacherBorrower]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_seacherBorrower](@Identity_Card int, @status varchar(100))
returns table
as 
return(
		select u.Identity_Card,
		u.Name,
		li.Li_Name, 
		bk.Book_Code,
		bk.Book_Name, 
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
/****** Object:  UserDefinedFunction [dbo].[fn_fetchBook]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_fetchBook]()
returns table
as
return(
	select Book_Code,Book_Name, Book_Author, Page, Language, Publish_Date, Description
	from Book
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_searchAllBorrower]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_searchAllBorrower](@Identity_Card int)
returns table
as 
return(
		select u.Identity_Card, 
		u.Name,
		li.Li_Name, 
		bk.Book_Name,
		b.Borrow_Date,
		b.Duration,
		b.Return_Date,
		b.Status,
		b.Description
		from Borrow b  inner join UserVisited u on b.UserID = u.UserID 
		inner join Book bk on b.Book_ID = bk.Book_ID inner join Librarian li on b.Li_ID = li.Li_ID
		where u.Identity_Card = @Identity_Card
)
GO
/****** Object:  UserDefinedFunction [dbo].[verifyLogin]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[verifyLogin](@Li_ID int, @Password nvarchar(50))
returns table
as return(
select Login.Li_ID, Login.Password, Login.Role, Login.Status from Login where Login.Li_ID = CAST(@Li_ID as int)
and Login.Password = @Password
and Login.Status = 'Active'
)
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
ALTER TABLE [dbo].[Login]  WITH CHECK ADD  CONSTRAINT [FK_Login_Librarian] FOREIGN KEY([Li_ID])
REFERENCES [dbo].[Librarian] ([Li_ID])
GO
ALTER TABLE [dbo].[Login] CHECK CONSTRAINT [FK_Login_Librarian]
GO
/****** Object:  StoredProcedure [dbo].[fn_BlockUser]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[fn_BlockUser](@Li_ID int)
as
begin
	update Login set Login.Status = 'Blocked' where Login.Li_ID = @Li_ID
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Brrower]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_Brrower](
@Book_Code int,
@Identity_Card int,
@Li_ID int,
@Borrow_Date date,
@Duration int,
@Return_Date date,
@Status nvarchar(100), 
@Description nvarchar(max)
)
as
begin
	declare @UserID int;
	declare @BookID int;
	
	select @BookID = Book.Book_ID from Book where Book.Book_Code = @Book_Code
	select @UserID = UserVisited.UserID from UserVisited where UserVisited.Identity_Card = @Identity_Card;
	print 'UserID >>>>' + cast(@UserID as nvarchar(200))
	print 'BookID >>>>' + cast(@BookID as nvarchar(200))
	insert into Borrow(Book_ID,UserID, Li_ID, Borrow_Date,Duration, Return_Date, Status, Description)
	values(@BookID, @UserID,@Li_ID, @Borrow_Date, @Duration, @Return_Date, @Status, @Description)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckOutUser]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_CheckOutUser]( @DateOut nvarchar(200), @DateIn nvarchar(200), @Identity_Card nvarchar(200))
as
begin
	print 'Date In >>>>> ' + @DateIn
	print 'Date Out >>>>> ' + @DateOut
	update UserVisited set UserVisited.Date_Out = @DateOut where UserVisited.Date_In = @DateIn
	and UserVisited.Identity_Card = CAST(@Identity_Card as int) 
	and UserVisited.Date_Out is null
end
GO
/****** Object:  StoredProcedure [dbo].[sp_createLibrarian]    Script Date: 9/3/2022 11:56:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_updateAllBorrowing]    Script Date: 9/3/2022 11:56:43 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_updateSpecificBorrower]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_updateSpecificBorrower](@Identiy_Card int, @Book_Code nvarchar(300))
as
begin
	-- update with specific book name
	update Borrow set Borrow.Status = 'Returned' from  Borrow b  inner join UserVisited u on b.UserID = u.UserID 
	inner join Book bk on bk.Book_ID = b.Book_ID
	where u.Identity_Card = @Identiy_Card AND  b.Status = 'Borrowing' AND bk.Book_Code = @Book_Code
end
GO
/****** Object:  StoredProcedure [dbo].[sq_addBook]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sq_addBook](
@Book_Code int,
@Book_Name nvarchar(500),
@Book_Author nvarchar(500),
@Page int,
@Language nvarchar(100),
@Publich_Date date,
@Description nvarchar(max)
)
as
begin 
insert into Book(Book_Code,Book_Name, Book_Author, Page, Language, Publish_Date, Description)
values(@Book_Code,@Book_Name, @Book_Author, @Page, @Language, @Publich_Date, @Description)
end
GO
/****** Object:  StoredProcedure [dbo].[sq_CreateLogin]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sq_CreateLogin](
@Password nvarchar(200),
@Li_ID nvarchar(200),
@Role nvarchar(100),
@Status nvarchar(100))
as
begin
	insert into Login(Li_ID,Password,Role,Status)
	values(@Li_ID,@Password, @Role, @Status)
end
GO
/****** Object:  StoredProcedure [dbo].[sq_createUser]    Script Date: 9/3/2022 11:56:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sq_createUser](
@Identity_Card nvarchar(200),
@Name nvarchar(200),
@Role nvarchar(200),
@Date_In datetime,
@Date_Out datetime
)
as
begin
	insert into UserVisited(Identity_Card,Name,Role,Date_In,Date_Out) 
	values(CAST(@Identity_Card as int),@Name, @Role, @Date_In, @Date_Out)
end
GO
USE [master]
GO
ALTER DATABASE [Library_Management] SET  READ_WRITE 
GO
