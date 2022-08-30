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
    }
}
