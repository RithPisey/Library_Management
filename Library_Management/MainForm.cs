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
    public partial class MainForm : Form
    {
       
       
        UserVisitor visitor;
        Library_Management.MyController.Login login;
        Borrower borrower;
        public MainForm()
        {
            InitializeComponent();

            visitor = new UserVisitor();
            login = new MyController.Login();
            borrower = new MyController.Borrower();
        }
        void fetchUserVistor()
        {
            UCheckedIn_DGrid.DataSource = visitor.FetchUserVisitor();
        }
        void fetchLibrarian()
        {
            Librarian_DGrid.DataSource = login.GetAllLibrarain();
            DataRow LiRow = login.GetLibrarianDetail(login.GetUserID());
            if (LiRow != null)
            {
                LiID_TxtBox.Text = LiRow.ItemArray[1].ToString();
                LibrarianName_TxtBox.Text = LiRow.ItemArray[1].ToString();
                LiGender_TxtBox.Text = LiRow.ItemArray[2].ToString();
                LiDoB_DPicker.Text = LiRow.ItemArray[3].ToString();
                Li_Description_RTxtBox.Text = LiRow.ItemArray[4].ToString();
            }
        }
        void fetchBorrower()
        {
            Borrower_DGrid.DataSource = borrower.FetchBorrower();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
           
            if(login.GetUserRole() == "Admin")
            {
                UserManag_Grid.Enabled = true;
            }
            else
            {
                UserManag_Grid.Enabled = false;
            }  

            fetchLibrarian();
            fetchUserVistor();
            fetchBorrower();

        }
        private void Librarian_DGrid_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Exit();
        }

        private void SearchUser_TxtBox_TextChanged(object sender, EventArgs e)
        {

            searchUserVistor();
        }

        private void SearchUser_Btn_Click(object sender, EventArgs e)
        {
            searchUserVistor();
        }
        void searchUserVistor()
        {
            DataTable dataTable;
            if (UnCheckOut_ChBox.Checked)
            {
                dataTable = visitor.SearchUserVisitor(SearchUser_TxtBox.Text);
                if (dataTable != null)
                {
                    UCheckedIn_DGrid.DataSource = dataTable;
                }
                else
                {
                    fetchUserVistor();
                }
            }
            else
            {
                dataTable = visitor.SearchAllUserVistor(SearchUser_TxtBox.Text);
                if (dataTable != null)
                {
                    UCheckedIn_DGrid.DataSource = dataTable;
                }
                else
                {
                    fetchUserVistor();
                }
            }
        }

        private void Add_Btn_Click(object sender, EventArgs e)
        {
            bool isSuccess = visitor.AddUserVistor(IdCard_Txtbox.Text, Name_TxtBox.Text, Role_Cbox.Text);
            MessageBox.Show(DateOut_DPicker.Text);
            if (isSuccess)
            {
                MessageBox.Show("Successful!!!", "Alert");
                fetchUserVistor();
            }
            else MessageBox.Show("Failure!!!", "Alert");
        }

        private void CheckOutUser_Btn_Click(object sender, EventArgs e)
        {
            bool isSuccess = visitor.CheckOutUser(IdCard_Txtbox.Text, DateIn_DPicker.Value, DateOut_DPicker.Value);
            MessageBox.Show(DateOut_DPicker.Text);
            if (isSuccess)
            {
                MessageBox.Show("Successful!!!", "Alert");
                fetchUserVistor();
            }
            else MessageBox.Show("Failure!!!", "Alert");
        }

        void ClearUserVisitorTxtBox()
        {
            IdCard_Txtbox.Text = "";
            Name_TxtBox.Text = "";
            Role_Cbox.Text = "";
        }

        private void UCheckedIn_DGrid_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                IdCard_Txtbox.Text = UCheckedIn_DGrid[0, e.RowIndex].Value.ToString();
                Name_TxtBox.Text = UCheckedIn_DGrid[1, e.RowIndex].Value.ToString();
                Role_Cbox.Text = UCheckedIn_DGrid[2, e.RowIndex].Value.ToString();
                DateIn_DPicker.Text = UCheckedIn_DGrid[3, e.RowIndex].Value.ToString();
            }
        }

        private void timer1_Tick(object sender, EventArgs e)
        {   
            userTime_Lb.Text = DateTime.Now.ToString("dd/MM/yyy hh:mm:ss");
        }

        private void Clear_Btn_Click(object sender, EventArgs e)
        {
            ClearUserVisitorTxtBox();
        }
    }
}
