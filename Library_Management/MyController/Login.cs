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


        Database myDatabase;
        public Login()
        {
            myDatabase = new Database();
        }
        public string VerifyLogin(string Li_ID, string password)
        {
            string returnString = "";
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
                            DataContext.UserID = dr.ItemArray[0].ToString();
                            if (password == dr.ItemArray[1].ToString())
                            {
                                if (dr.ItemArray[3].ToString() == "Active")
                                {
                                    DataContext.UserRole = dr.ItemArray[2].ToString();
                                    returnString = "success";
                                }
                                else returnString = "User has been blocked!";
                            }
                            else returnString = "Wrong password!";
                        }
                        else returnString = "Wrong Username!";
                    }
                }
                else returnString = "error";
            }
            else returnString = "error";
            return returnString;
        }

        public DataTable GetLibrarianDetail(string LiID)
        {
            //select * from fn_getLibrarain(1001)

            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable($"select * from fn_getLibrarain({LiID})");
                if (dt != null)
                {
                    return dt;
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
                DataTable dt = myDatabase.getTable($" select *" +
                    $" from Librarian");
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
    }
}
