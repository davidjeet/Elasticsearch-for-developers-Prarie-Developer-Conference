using StackExchangeModel;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Windows.Forms;



namespace Winforms.XmlToMongo
{
    public partial class Form1 : Form
    {        
        private IEnumerable<User> Users;
        private IEnumerable<Comment> Comments;
        private IEnumerable<Post> Posts;
        private BackgroundWorker backgroundWorker1;

        private const int STEPS = 5; 

        public Form1()
        {
            InitializeComponent();
            txtFolderPath.Text = folderBrowserDialog1.SelectedPath;

            backgroundWorker1 = new BackgroundWorker();
            backgroundWorker1.DoWork += backgroundWorker1_DoWork;
            backgroundWorker1.ProgressChanged +=backgroundWorker1_ProgressChanged;
            backgroundWorker1.RunWorkerCompleted += backgroundWorker1_RunWorkerCompleted;
            backgroundWorker1.WorkerReportsProgress = true;
        }

        private void btnSelectFolder_Click(object sender, EventArgs e)
        {
            DialogResult result = folderBrowserDialog1.ShowDialog();
            txtFolderPath.Text = folderBrowserDialog1.SelectedPath;
        }

        private void btnETL_Click(object sender, EventArgs e)
        {
            txtResults.Text = "";
            txtProgress.Text = "";
            progressBar1.Value = 0;
            this.backgroundWorker1.RunWorkerAsync();
        }

        private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            BackgroundWorker worker = sender as BackgroundWorker;
            Users =  ImporterHelper<User>.GetAllUsers(txtFolderPath.Text);
            worker.ReportProgress(GetPercentage(1, STEPS), "Users Imported, count: " + Users.Count());

            Posts = ImporterHelper<Post>.GetAllPosts(txtFolderPath.Text);
            worker.ReportProgress(GetPercentage(2, STEPS), "Posts Imported, count: " + Posts.Count());

            Comments = ImporterHelper<Comment>.GetAllComments(txtFolderPath.Text);
            worker.ReportProgress(GetPercentage(3, STEPS), "Comments Imported, count: " + Comments.Count()); 
        }

        private void backgroundWorker1_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            progressBar1.Value = e.ProgressPercentage;
            txtProgress.Text = string.Format("{0}% complete", e.ProgressPercentage);

            txtResults.Text += e.UserState.ToString() + Environment.NewLine;
        }

        private void backgroundWorker1_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            txtResults.Text += "Import complete!!!!!!!" + Environment.NewLine;
            this.backgroundWorker2.RunWorkerAsync();
        }

        private void backgroundWorker2_DoWork(object sender, DoWorkEventArgs e)
        {
            BackgroundWorker worker = sender as BackgroundWorker;

            ExporterHelper<User>.GetInstance().ExportAllUsers(Users);
            worker.ReportProgress(GetPercentage(4, STEPS), "Users Exported!!!!"); 

            ExporterHelper<Post>.GetInstance().ExportAllPostsAndComments(Posts, Comments);
            worker.ReportProgress(GetPercentage(5, STEPS), "Posts & Comments Exported!!!!"); 
        }

        private void backgroundWorker2_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            progressBar1.Value = e.ProgressPercentage;
            txtProgress.Text = string.Format("{0}% complete", e.ProgressPercentage);
            txtResults.Text += e.UserState.ToString() + Environment.NewLine;
        }

        private void backgroundWorker2_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            txtResults.Text += "Export complete!!!!!!!" + Environment.NewLine;
        }


        private int GetPercentage(int numerator, int denominator)
        {
            double val = Convert.ToDouble(numerator) / Convert.ToDouble(denominator);
            return Convert.ToInt32(val * 100);
        }

        //private static IEnumerable<XElement> GetRows(string filename)
        //{
        //    var rows = from r in XElement.Load(GetFile(filename)).Elements("row")
        //               select r;
        //    return rows;
        //}

    }
}
