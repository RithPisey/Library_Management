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
        Book book;
        Librarian librarian;
        UserLogin userLogin;
        public MainForm()
        {
            InitializeComponent();

            visitor = new UserVisitor();
            login = new MyController.Login();
            borrower = new MyController.Borrower();
            book = new Book();
            librarian = new Librarian();
            userLogin = new UserLogin();
        }
        void fetchUserVistor()
        {
            UCheckedIn_DGrid.DataSource = visitor.FetchUserVisitor();
        }
        void fetchLibrarian()
        {
            Librarian_DGrid.DataSource = login.GetAllLibrarain();
            DataTable LiRow = login.GetLibrarianDetail(DataContext.UserID);
            
            if(LiRow != null)
            {        
                foreach(DataRow Row in LiRow.Rows)
                {
                    LiID_TxtBox.Text = Row.ItemArray[0].ToString();
                    Librarian_Lb.Text = LibrarianName_TxtBox.Text;
                    LibrarianName_TxtBox.Text = Row.ItemArray[1].ToString();
                    LiGender_TxtBox.Text = Row.ItemArray[2].ToString();
                    LiDoB_DPicker.Text = Row.ItemArray[3].ToString();
                    Li_Description_RTxtBox.Text = Row.ItemArray[4].ToString();
                }
            }
           
        }
        void fetchBorrower()
        {
            Borrower_DGrid.DataSource = borrower.FetchBorrower();
            UserMng();
        }
        void UserMng()
        {
            if (UserMngFilter_Cbox.Text == "Librarian")
            {
                UserManag_DGrid.DataSource = login.GetAllLibrarain();
            }
            else if (UserMngFilter_Cbox.Text == "User Login")
            {
                fetchUserLogin();
            }
        }
        void fetchBook()
        {
            Book_DGrid.DataSource = book.FetchBook();
        }

        void fetchUserLogin()
        {
            UserManag_DGrid.DataSource = userLogin.fetchUserLogin();
        }
        

        private void MainForm_Load(object sender, EventArgs e)
        {
            MessageBox.Show(DataContext.UserRole);
            if(DataContext.UserRole == "Admin")
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
            fetchBook();

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
            DateIn_DPicker.Value = DateTime.Now;
            DateOut_DPicker.Value = DateTime.Now;
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

        private void TimeNowUVisitor_Btn_Click(object sender, EventArgs e)
        {
            DateTimePicker myPicker = new DateTimePicker();
            myPicker.Value = DateTime.Now;

            DateOut_DPicker.Value = myPicker.Value;


        }

        private void UnCheckOut_ChBox_CheckedChanged(object sender, EventArgs e)
        {
            searchUserVistor();
        }

        private void AddBorrower_Btn_Click(object sender, EventArgs e)
        {
            //MessageBox.Show($"{BookCodeBorr_TxtBox.Text} {IdCardBorr_txtBox.Text} {DataContext.UserID} {BorrowDate_DPIcker.Value} {Duration_TxtBox.Text},{ReturnDate_DPicker.Value}, 'Borrowing', {Description_RTxtBox.Text}");

            bool isSuccess = borrower.AddBorrower(BookCodeBorr_TxtBox.Text, IdCardBorr_txtBox.Text, DataContext.UserID, BorrowDate_DPIcker.Value, Duration_TxtBox.Text, ReturnDate_DPicker.Value, "Borrowing", Description_RTxtBox.Text);
            
            if (isSuccess)
            {
                MessageBox.Show("Successful!!!", "Alert");
                fetchBorrower();
            }
            else MessageBox.Show("Failure!!!", "Alert");
        }

        private void AddBook_Btn_Click(object sender, EventArgs e)
        {
            bool isSuccess = book.AddBook(BookCode_TxtBox.Text, BookName_TxtBox.Text, Author_TxtBox.Text,Page_TxtBox.Text, BookLang_TxtBox.Text, Publish_DPicker.Value, BookDesc_RTxtBox.Text);
            if (isSuccess)
            {
                MessageBox.Show("Successful!!!", "Alert");
                fetchBook();
            }
            else MessageBox.Show("Failure!!!", "Alert");
        }

        private void ClearBook_Btn_Click(object sender, EventArgs e)
        {
            BookCode_TxtBox.Text = "";
            BookName_TxtBox.Text = "";
            Author_TxtBox.Text = "";
            BookLang_TxtBox.Text = "";
            Page_TxtBox.Text = "";
            BookDesc_RTxtBox.Text = "";
            Publish_DPicker.Value = DateTime.Now;
        }

        private void Book_DGrid_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                BookCode_TxtBox.Text = Book_DGrid[0, e.RowIndex].Value.ToString();
                BookName_TxtBox.Text = Book_DGrid[1, e.RowIndex].Value.ToString();
                Author_TxtBox.Text = Book_DGrid[2, e.RowIndex].Value.ToString();
                Page_TxtBox.Text = Book_DGrid[3, e.RowIndex].Value.ToString();
                BookLang_TxtBox.Text = Book_DGrid[4, e.RowIndex].Value.ToString();
                Publish_DPicker.Text = Book_DGrid[5, e.RowIndex].Value.ToString();
                BookDesc_RTxtBox.Text = Book_DGrid[6, e.RowIndex].Value.ToString();          
            }
        }

        private void SearchBook_TxtBox_TextChanged(object sender, EventArgs e)
        {
            serachBook();
        }

        void serachBook()
        {
            DataTable dataTable;
            dataTable = book.SearchBook(SearchBook_TxtBox.Text);
            if (dataTable.Rows.Count > 0)
            {
                Book_DGrid.DataSource = dataTable;
            }
            else
            {
               
                fetchBook();
            }
           
        }

        private void SearchBook_Btn_Click(object sender, EventArgs e)
        {
            serachBook();
        }
        void searchBorrower()
        {
            DataTable dataTable;
            if (Borrowing_CkBox.Checked)
            {
                dataTable = borrower.SearchBorrowingUser(SearchBorr_TxtBox.Text);
                if (dataTable == null)
                {
                    fetchBorrower();
                    return;
                }
                else if (dataTable.Rows.Count > 0)
                {
                    Borrower_DGrid.DataSource = dataTable;
                }
                else
                {
                    fetchBorrower();
                }
                try
                {
                  
                }
                catch(Exception ex)
                {
                    fetchBorrower();
                }             
            }
            else
            {
                try
                {
                    dataTable = borrower.SearchAllBorrower(SearchBorr_TxtBox.Text);
                    if (dataTable == null)
                    {
                        fetchBorrower();
                        return;
                    }
                    else if (dataTable.Rows.Count > 0)
                    {
                        Borrower_DGrid.DataSource = dataTable;
                    }
                    else
                    {
                        fetchBorrower();
                    }
                }
                catch (Exception ex)
                {
                    fetchUserVistor();
                }
            }   
        }
        private void SearchBorr_TxtBox_TextChanged(object sender, EventArgs e)
        {
            searchBorrower();
        }

        private void SearchBorr_Btn_Click(object sender, EventArgs e)
        {
            searchBorrower();
        }

        private void Borrower_DGrid_CellEnter(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                IdCardBorr_txtBox.Text = Borrower_DGrid[0,e.RowIndex].Value.ToString();
                BookCodeBorr_TxtBox.Text = Borrower_DGrid[3, e.RowIndex].Value.ToString();
                Librarian_Lb.Text = Borrower_DGrid[2, e.RowIndex].Value.ToString();
                Duration_TxtBox.Text = Borrower_DGrid[6, e.RowIndex].Value.ToString();
                BorrowDate_DPIcker.Text = Borrower_DGrid[5, e.RowIndex].Value.ToString();
                ReturnDate_DPicker.Text = Borrower_DGrid[7,e.RowIndex].Value.ToString();
                Description_RTxtBox.Text = Borrower_DGrid[9, e.RowIndex].Value.ToString();
            }
        }

        private void BorrReturned_Btn_Click(object sender, EventArgs e)
        {
            bool isSuccess =borrower.ReturnedBook(IdCardBorr_txtBox.Text, BookCodeBorr_TxtBox.Text);
            if (isSuccess)
            {
                MessageBox.Show("Successful!!!", "Alert");
                fetchBorrower();
            }
            else MessageBox.Show("Failure!!!", "Alert");
        }

        private void ClearBorrower_Btn_Click(object sender, EventArgs e)
        {
            IdCardBorr_txtBox.Text = "";
            BookCodeBorr_TxtBox.Text = "";
            BookCodeBorr_TxtBox.Text = "";
            Duration_TxtBox.Text = "";
            BorrowDate_DPIcker.Value = DateTime.Now;
            ReturnDate_DPicker.Value = DateTime.Now;
        }

        private void AddLibrarian_Btn_Click(object sender, EventArgs e)
        {
            bool isSuccess = librarian.AddLibrarian(AddLIbrarian_TxtBox.Text,AddLiGender_TxtBox.Text, AddLiDoB_DPicker.Value, AddLiDiscription_TxtBox.Text);
            if (isSuccess)
            {
                MessageBox.Show("Successful!!!", "Alert");
               fetchLibrarian();
            }
            else MessageBox.Show("Failure!!!", "Alert");
        }

        private void AddUserLog_Btn_Click(object sender, EventArgs e)
        {
            bool isSuccess = userLogin.AddUserLogin(PasswordLog_TxtBox.Text, SetLibrarianID_TxtBox.Text, RoleLogin_Cbox.Text, StatusTxtBox_CBox.Text);
            if (isSuccess)
            {
                MessageBox.Show("Successful!!!", "Alert");
                fetchLibrarian();
            }
            else MessageBox.Show("Failure!!!", "Alert");
        }

        private void ClearLIbrarain_Btn_Click(object sender, EventArgs e)
        {
            AddLIbrarian_TxtBox.Text = "";
            AddLiGender_TxtBox.Text = "";
            AddLiDoB_DPicker.Value = DateTime.Now;
            AddLiDiscription_TxtBox.Text = "";
        }

        private void ClearLogFrm_Btn_Click(object sender, EventArgs e)
        {
            PasswordLog_TxtBox.Text = "";
            SetLibrarianID_TxtBox.Text = "";
            RoleLogin_Cbox.Text = "";
            StatusTxtBox_CBox.Text = "";
        }

        private void BlockUserLog_Btn_Click(object sender, EventArgs e)
        {
            bool isSuccess = userLogin.BlockUser(SetLibrarianID_TxtBox.Text);
            if (isSuccess)
            {
                MessageBox.Show("Successful!!!", "Alert");
                fetchLibrarian();
            }
            else MessageBox.Show("Failure!!!", "Alert");
        }

        private void UserManag_DGrid_CellEnter(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void UserMngFilter_Cbox_SelectedIndexChanged(object sender, EventArgs e)
        {
            UserMng();
        }
    }
}
