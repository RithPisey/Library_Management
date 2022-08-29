using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Library_Management
{
    internal class Controller
    {
   
        string UserRole;
        public string VerifyLogin(string Li_ID, string password)
        {
            Database myDatabase = new Database();
    
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
                                return "success";
                            }

                        }

                    }
                }else return "error";
               
            
            }else return "error";

            return "";

        }

        public string GetUserRole()
        {
            return UserRole;
        }
    }
}
