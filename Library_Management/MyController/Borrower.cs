using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Library_Management.MyController
{
    internal class Borrower
    {
        readonly Database myDatabase;
        public Borrower()
        {
            myDatabase = new Database();
        }

        public DataTable FetchBorrower()
        {

            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable("select * from fn_fetchBorrower()");
                if (dt != null)
                {
                    return dt;
                }
                else return null;
            }
            return null;
        }

        public bool AddBorrower(string BookID, string Identity_Card, string Li_ID, DateTime Borrow_Date, string Duration, DateTime Return_Date, string Status, string Description)
        {
            //exec sp_Brrower 123456789,20191006,1001,'2/2/2022', 7, '2/7/2022', 'Borrowing', null
            if (myDatabase.getConnectionState() == "open")
            {
                string sql = $"exec sp_Brrower '{BookID}','{Identity_Card}','{Li_ID}','{Borrow_Date}', '{Duration}', '{Return_Date}', '{Status}', '{Description}'";
                return myDatabase.ExecuteQuery(sql);
            }
            return false;
        }

        public DataTable SearchBorrowingUser(string IdentityCard)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable($"select * from [fn_seacherBorrower]({IdentityCard}, 'Borrowing')");
                if (dt != null)
                {
                    return dt;
                }
                else return null;
            }
            return null;
        }

        public DataTable SearchAllBorrower(string IdentityCard)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable($"select * from fn_searchAllBorrower({IdentityCard})");
                if (dt != null)
                {
                    return dt;
                }
                else return null;
            }
            return null;
        }

        public bool ReturnedBook(string IdentityCard, string bookCode)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                string sql = $"exec sp_updateSpecificBorrower {IdentityCard}, {bookCode}";
                return myDatabase.ExecuteQuery(sql);
            }
            return false;
        }

        public DataTable FetchReturned()
        {
            if(myDatabase.getConnectionState() == "open")
            {
                return myDatabase.getTable("" +
                    "select " +
                    "UserVisited.Identity_Card," +
                    "UserVisited.Name," +
                    "Librarian.Li_Name," +
                    "Book.Book_Code," +
                    "Book.Book_Name," +
                    "Borrow.Borrow_Date," +
                    "Borrow.Duration," +
                    "Borrow.Return_Date," +
                    " Borrow.Status," +
                    "Borrow.Description" +
                    " from Borrow inner join " +
                    "Librarian on Borrow.Li_ID = Librarian.Li_ID " +
                    "inner join UserVisited " +
                    "on Borrow.UserID = UserVisited.UserID " +
                    "inner join Book on Book.Book_ID = Borrow.Book_ID where Borrow.Status = 'Returned'");
            }
            return null;
        }

        public DataTable FetchBorrowing()
        {

            if (myDatabase.getConnectionState() == "open")
            {
                return myDatabase.getTable("" +
                    "select " +
                    "UserVisited.Identity_Card," +
                    "UserVisited.Name," +
                    "Librarian.Li_Name," +
                    "Book.Book_Code," +
                    "Book.Book_Name," +
                    "Borrow.Borrow_Date," +
                    "Borrow.Duration," +
                    "Borrow.Return_Date," +
                    " Borrow.Status," +
                    "Borrow.Description" +
                    " from Borrow inner join " +
                    "Librarian on Borrow.Li_ID = Librarian.Li_ID " +
                    "inner join UserVisited " +
                    "on Borrow.UserID = UserVisited.UserID " +
                    "inner join Book on Book.Book_ID = Borrow.Book_ID where Borrow.Status = 'Borrowing'");
            }
            return null;
        }

        public DataTable SearchReturnedUser(string IdentityCard)
        {

            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable($"select * from [fn_seacherBorrower]({IdentityCard}, 'Returned')");
                if (dt != null)
                {
                    return dt;
                }
                else return null;
            }
            return null;
        }
    }
}
