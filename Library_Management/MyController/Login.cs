using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Library_Management.MyController
{
    internal class Login
    {
        string UserRole = "";
        string UserID = "";


        Database myDatabase;
        public Login()
        {
            myDatabase = new Database();
        }
        public string VerifyLogin(string Li_ID, string password)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable("select * from verifyLogin(" + Li_ID + ", '" + password + "')");
                if (dt != null)
                {
                    long rowNum = dt.Rows.Count;
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (Li_ID == dr.ItemArray[0].ToString())
                        {
                            if (password == dr.ItemArray[1].ToString())
                            {
                                UserRole = dr.ItemArray[2].ToString();
                                UserID = dr.ItemArray[0].ToString();
                                return "success";
                            }
                        }
                    }
                }
                else return "error";
            }
            else return "error";
            return "";

        }

        public DataRow? GetLibrarianDetail(string LiID)
        {
            //select * from fn_getLibrarain(1001)

            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable($"select * from fn_getLibrarain({LiID})");
                if (dt != null)
                {
                    long rowNum = dt.Rows.Count;
                    foreach (DataRow dr in dt.Rows)
                    {
                        return dr;
                    }
                }
                else return null;
            }
            else return null;
            return null;
    
        }

        public DataTable GetAllLibrarain()
        {
           
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable($" select Librarian.Li_ID, Librarian.Li_Name, Librarian.Li_Gender, Librarian.Li_DoB, Librarian.Description" +
                    $" from Librarian inner join Login on Librarian.Li_ID = Login.Li_ID");
                if (dt != null)
                {
                    return dt;
                }
                else return null;
            }
            else return null;
            return null;
        }

        public string GetUserRole()
        {
            return UserRole;
        }
        public string GetUserID()
        {
            return UserID;
        }
    }
}
