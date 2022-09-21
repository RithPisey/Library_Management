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
        Database myDatabase;
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
    }
}
