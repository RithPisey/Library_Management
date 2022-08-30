using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Library_Management.MyController
{
    internal class UserVisitor
    {
        
        Database myDatabase;
        public UserVisitor()
        {
            myDatabase = new Database();
        }
       

        public DataTable FetchUserVisitor()
        {
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable("select * from fn_fetchUserVistor()");
                if (dt != null)
                {
                    return dt;
                }
                else return null;
            }
            return null;
        }

        public DataTable SearchUserVisitor(string IdentityCard)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable("select * from fnSearchUserVisitor(" + IdentityCard + ")");
                if (dt != null)
                {
                    return dt;
                }
                else return null;
            }
            return null;
        }

        public DataTable SearchAllUserVistor(string IdentityCard)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                DataTable dt = myDatabase.getTable("select* from fn_SearchAllUserVistor(" + IdentityCard + ")");
                if (dt != null)
                {
                    return dt;
                }
                else return null;
            }
            return null;
        }

        public bool AddUserVistor(string IdentityCard, string Name, string Role)
        {
            if (myDatabase.getConnectionState() == "open")
            {
                return myDatabase.ExecuteQuery($"exec sq_createUser {IdentityCard}, '{Name}','{Role}','{DateTime.Now}', null");
            }
            return false;
        }

        public bool CheckOutUser(string IdentityCard, DateTime dateIn, DateTime dateOut)
        {
            if (myDatabase.getConnectionState() == "open")
            {

                return myDatabase.ExecuteQuery($"exec  sp_CheckOutUser '{dateOut}', '{dateIn}','{IdentityCard}' ");
            }
            return false;
        }

       
    }
}
