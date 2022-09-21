using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Library_Management.MyController
{
    internal class Librarian
    {
        Database myDatabase;
        public Librarian()
        {
            myDatabase = new Database();
        }

        public bool AddLibrarian(string Li_Name, string Gender, DateTime DoB, string Description)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                return myDatabase.ExecuteQuery($"exec sp_createLibrarian '{Li_Name}', '{Gender}','{DoB}','{Description}'");
            }
            return false;
        }

        public DataTable SearchLibrarian(string Li_ID)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable("select * from Librarian where Li_ID = " + Li_ID + "");
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
