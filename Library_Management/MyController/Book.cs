using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Library_Management.MyController
{
    internal class Book
    {
        Database myDatabase;
        public Book()
        {
            myDatabase = new Database();
        }

        public DataTable FetchBook()
        {
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable("select * from fn_fetchBook()");
                if (dt != null)
                {
                    return dt;
                }
                else return null;
            }
            return null;
        }

        public bool AddBook(string BookCode, string BookName, string BookAuthor, string Page, string Language, DateTime PublishDate,string Description)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                return myDatabase.ExecuteQuery($"exec sq_addBook {BookCode}, '{BookName}','{BookAuthor}','{Page}', '{Language}', '{PublishDate}','{Description}' ");
            }
            return false;
        }

        public DataTable SearchBook(string query)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable($"select * from fn_searchBook('{query}')");
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
