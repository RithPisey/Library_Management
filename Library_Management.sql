--### Create Procedure sq_createLibrarian ###
--alter proc sp_createLibrarian(
--@Li_Name nvarchar(300), 
--@Li_Gender nvarchar(100),
--@Li_DoB date,
--@Description nvarchar(max)=null
--)
--as
--begin
-- insert into Librarian(Li_Name, Li_Gender, Li_DoB, Description)
-- values(@Li_Name, @Li_Gender, @Li_DoB, @Description)
--end

--exec sp_createLibrarian 
--T3Name, 
-- "M",
--"5-12-01",
--null
--###############################

--### Create Procedure sq_AddBook###
--create proc sq_addBook(
--@Book_Name nvarchar(500),
--@Book_Author nvarchar(500),
--@Page int,
--@Language nvarchar(100),
--@Publich_Date date,
--@Description nvarchar(max) = null
--)
--as
--begin 
--insert into Book(Book_Name, Book_Author, Page, Language, Publish_Date, Description)
--values(@Book_Name, @Book_Author, @Page, @Language, @Publich_Date, @Description)
--end

--exec sq_addBook 
--"Test Book3", "Test Author3", 300, "Khmer", "3-15-05", null
--###############################

--### Create Procedure sq_CreateLogin###
--ALTER proc [dbo].[sq_CreateLogin](
--@Username varchar(200),
--@Password nvarchar(200),
--@Role nvarchar(100),
--@Status nvarchar(100))
--as
--begin
--	insert into Login(Username,Password,Role,Status)
--	values( @Username, @Password, @Role, @Status)
--end

--exec sq_CreateLogin 5, "Test2", "test2", "User", "active"
--###############################

--### Create Procedure sq_CreateUser###
--create proc sq_createUser(
--@Identity_Card int,
--@Role nvarchar(200),
--@Date_In datetime,
--@Date_Out datetime
--)
--as
--begin
--	insert into UserVisited(Identity_Card,Role,Date_In,Date_Out) 
--	values(@Identity_Card, @Role, @Date_In, @Date_Out)
--end

--exec sq_createUser 289791, "Teacher", "2-2-22 7:30", "2-2-22 8:40"
--###############################

--### Create Procedure sp_Borrower###
--create proc sp_Brrower(
--@UserID int,
--@BookID int,
--@Li_ID int,
--@Borrow_Date date,
--@Duration int,
--@Return_Date date,
--@Status nvarchar(100), 
--@Description nvarchar(max)
--)
--as
--begin
--	insert into Borrow(UserID, Book_ID, Li_ID, Borrow_Date,Duration, Return_Date, Status, Description)
--	values(@UserID, @BookID, @Li_ID, @Borrow_Date, @Duration, @Return_Date, @Status, @Description)
--end

--exec sp_Brrower  124511, 3, 1, "2-2-22", 7, "2-9-22", "Borrowing", null
--###############################

--### Create Procedure ...###

--testing inner join borrow table and user table
--testing union borrow table and user table
--testing update table borrow

-- inner join Borrow and UserVisited
--select * from Borrow

--### Create Function fn_seacherBorrower ###
--create function fn_seacherBorrower(@Identity_Card int, @status varchar(100))
--returns table
--as 
--return(
--		select u.Identity_Card, 
--		bk.Book_Name, 
--		li.Li_Name, 
--		b.Borrow_Date,
--		b.Duration,
--		b.Return_Date,
--		b.Status,
--		b.Description
--		from Borrow b  inner join UserVisited u on b.UserID = u.UserID 
--		inner join Book bk on b.Book_ID = bk.Book_ID inner join Librarian li on b.Li_ID = li.Li_ID
--		where u.Identity_Card = @Identity_Card AND  b.Status = @status
--)

--select * from fn_seacherBorrower(321841,'Returned')
--###############################

--### Create Procedure  sp_updateAllBorrowing ###
--create proc sp_updateAllBorrowing(@Identiy_Card int)
--as
--begin
--	-- update all borrowing status to returned
--	update Borrow set Borrow.Status = 'Borrowing' from  Borrow b  inner join UserVisited u on b.UserID = u.UserID 
--	where u.Identity_Card = @Identiy_Card AND  b.Status = 'Returned'
--end
--###############################

--### Create Procedure  sp_updateSpecificBorrower ###
--create proc sp_updateSpecificBorrower(@Identiy_Card int, @Book_Name nvarchar(300))
--as
--begin
--	-- update with specific book name
--	update Borrow set Borrow.Status = 'Returned' from  Borrow b  inner join UserVisited u on b.UserID = u.UserID 
--	inner join Book bk on bk.Book_ID = b.Book_ID
--	where u.Identity_Card = @Identiy_Card AND  b.Status = 'Borrowing' AND bk.Book_Name = @Book_Name
--end
--###############################

-- ### create fn_searchBook ###
-- search book
--create function fn_searchBook(@Book_Name nvarchar(300))
--returns table
--as 
--return(
--	select * from Book where Book.Book_Name = @Book_Name
--)
--###############################

-- create user login

alter function verifyLogin(@Li_ID int, @Password nvarchar(50))
returns table
as return(
select Login.Li_ID, Login.Password, Login.Role from Login where Login.Li_ID = CAST(@Li_ID as int) and Login.Password = @Password
)

select * from verifyLogin('1001', 'DefaultAdmin')
-- delete user login
--	delete book

















