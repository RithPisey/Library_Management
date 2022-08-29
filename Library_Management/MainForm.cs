using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Library_Management
{
    public partial class MainForm : Form
    {
        Controller controller;
        public MainForm()
        {
            InitializeComponent();
            controller = new Controller();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            if(controller.GetUserRole() == "Admin")
            {
                UserManag_Grid.Enabled = true;
            }
            else
            {
                UserManag_Grid.Enabled = false;
            }
           
        }

        private void Librarian_DGrid_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Exit();
        }
    }
}
