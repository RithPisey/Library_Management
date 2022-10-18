using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Security;

namespace Library_Management
{
    internal class Database
    {
        string connectionString = "";
        SqlConnection connection;
        string connectionState = "";
        public Database()
        {
            string server = "DESKTOP-TD1L1JK\\SQLEXPRESS";
            string database = "Library_Management";
            string userID = "sa" ;
            string password = "123";
           connectionString = "Server="+server+";Database="+database+";User Id="+userID+";Password="+password+";";

            connection = new SqlConnection(connectionString);
            if(connection.State == ConnectionState.Closed)
            {
                connection.Open();
                connectionState = "open";
            }
        }

        public string getConnectionState()
        {
            return connectionState;
        }

        public DataTable getTable(SqlCommand sqlCommand)
        {
            //userDataTable.Clear();
          
            DataTable table = new DataTable();
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand);

            sqlDataAdapter.Fill(table);
            return table;
            //return userDataTable.Tables[TableName] as DataTable;
        }

        public DataTable getTable(string sql)
        {
            //userDataTable.Clear();  
            DataTable table = new DataTable();
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sql, connectionString);

            try
            {
               sqlDataAdapter.Fill(table);
                return table;
            }catch(Exception ex)
            {
                return null;
            }
            return table;
            //return userDataTable.Tables[TableName] as DataTable;
        }

        public bool ExecuteQuery(string sql)
        {
            SqlCommand sqlCommand = new SqlCommand(sql, connection);
            //sqlCommand.ExecuteNonQuery();
            try
            {
                sqlCommand.ExecuteNonQuery();
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

    }
}
