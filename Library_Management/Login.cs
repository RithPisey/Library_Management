using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Library_Management.MyController;

namespace Library_Management
{
    public partial class Login : Form
    {
        Library_Management.MyController.Login login;
        public Login()
        {
            InitializeComponent();
            login = new Library_Management.MyController.Login();
        }
        
        private void Login_Btn_Click(object sender, EventArgs e)
        {
            if(LibIDLogin_TxtBox.Text == "" || LoginPass_TxtBox.Text == "")
            {
                MessageBox.Show("Make sure all text box are not empty!", "Error");
                return;
            }
            string status = login.VerifyLogin(LibIDLogin_TxtBox.Text, LoginPass_TxtBox.Text);
            if(status == "success")
            {
                MainForm mainForm = new MainForm();
                mainForm.Show();
                this.Hide();
            }
            else if(status == "error")
            {
                MessageBox.Show("There's something wrong! Please complete your password and  Librarian ID again.","Error");
            }
        }

        private void Login_Load(object sender, EventArgs e)
        {

        }
    }
}
