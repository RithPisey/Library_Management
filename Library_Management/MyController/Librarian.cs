using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
    }
}
