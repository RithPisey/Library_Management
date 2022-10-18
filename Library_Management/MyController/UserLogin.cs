using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Library_Management.MyController
{
    internal class UserLogin
    {
        Database myDatabase;
        public UserLogin()
        {
            myDatabase = new Database();
        }

        public bool AddUserLogin(string password, string Li_ID, string Role, string Status)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                return myDatabase.ExecuteQuery($"exec sq_CreateLogin '{password}', '{Li_ID}','{Role}','{Status}'");
            }
            return false;
        }

        public bool BlockUser(string Li_ID)
        {
            //exec fn_BlockUser

            if (myDatabase.getConnectionState() == "open")
            {
                return myDatabase.ExecuteQuery($"exec fn_BlockUser {Li_ID}");
            }
            return false;
        }

        public DataTable fetchUserLogin()
        {
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable("select Login.Li_ID, Login.Password, Role, Status from Login where Login.Status = 'Active'");
                if (dt != null)
                {
                    return dt;
                }
                else return null;
            }
            return null;
        }

        public DataTable searchUserLogin(string Li_ID)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable("select Login.Li_ID, Login.Password, Role, Status from Login where Li_ID = " + Li_ID + "");
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
