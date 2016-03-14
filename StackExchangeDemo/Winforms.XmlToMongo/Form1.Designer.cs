namespace Winforms.XmlToMongo
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.txtFolderPath = new System.Windows.Forms.TextBox();
            this.btnSelectFolder = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.folderBrowserDialog1 = new System.Windows.Forms.FolderBrowserDialog();
            this.txtResults = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.btnETL = new System.Windows.Forms.Button();
            this.backgroundWorker2 = new System.ComponentModel.BackgroundWorker();
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            this.txtProgress = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // txtFolderPath
            // 
            this.txtFolderPath.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtFolderPath.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtFolderPath.Location = new System.Drawing.Point(152, 11);
            this.txtFolderPath.Margin = new System.Windows.Forms.Padding(5);
            this.txtFolderPath.Name = "txtFolderPath";
            this.txtFolderPath.Size = new System.Drawing.Size(453, 26);
            this.txtFolderPath.TabIndex = 0;
            // 
            // btnSelectFolder
            // 
            this.btnSelectFolder.Location = new System.Drawing.Point(615, 13);
            this.btnSelectFolder.Margin = new System.Windows.Forms.Padding(5);
            this.btnSelectFolder.Name = "btnSelectFolder";
            this.btnSelectFolder.Size = new System.Drawing.Size(130, 23);
            this.btnSelectFolder.TabIndex = 1;
            this.btnSelectFolder.Text = "Select Import Folder";
            this.btnSelectFolder.UseVisualStyleBackColor = true;
            this.btnSelectFolder.Click += new System.EventHandler(this.btnSelectFolder_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(39, 14);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(105, 17);
            this.label1.TabIndex = 2;
            this.label1.Text = "Folder location:";
            // 
            // folderBrowserDialog1
            // 
            this.folderBrowserDialog1.Description = "Select a folder for importing ";
            this.folderBrowserDialog1.SelectedPath = "C:\\temp\\stackexchange\\cooking";
            this.folderBrowserDialog1.ShowNewFolderButton = false;
            // 
            // txtResults
            // 
            this.txtResults.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtResults.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtResults.Location = new System.Drawing.Point(136, 126);
            this.txtResults.Margin = new System.Windows.Forms.Padding(5);
            this.txtResults.Multiline = true;
            this.txtResults.Name = "txtResults";
            this.txtResults.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtResults.Size = new System.Drawing.Size(932, 479);
            this.txtResults.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(69, 126);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(59, 17);
            this.label2.TabIndex = 4;
            this.label2.Text = "Results:";
            // 
            // btnETL
            // 
            this.btnETL.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnETL.Location = new System.Drawing.Point(454, 68);
            this.btnETL.Margin = new System.Windows.Forms.Padding(5);
            this.btnETL.Name = "btnETL";
            this.btnETL.Size = new System.Drawing.Size(141, 23);
            this.btnETL.TabIndex = 5;
            this.btnETL.Text = "Begin ETL!";
            this.btnETL.UseVisualStyleBackColor = true;
            this.btnETL.Click += new System.EventHandler(this.btnETL_Click);
            // 
            // backgroundWorker2
            // 
            this.backgroundWorker2.WorkerReportsProgress = true;
            this.backgroundWorker2.DoWork += new System.ComponentModel.DoWorkEventHandler(this.backgroundWorker2_DoWork);
            this.backgroundWorker2.ProgressChanged += new System.ComponentModel.ProgressChangedEventHandler(this.backgroundWorker2_ProgressChanged);
            this.backgroundWorker2.RunWorkerCompleted += new System.ComponentModel.RunWorkerCompletedEventHandler(this.backgroundWorker2_RunWorkerCompleted);
            // 
            // progressBar1
            // 
            this.progressBar1.ForeColor = System.Drawing.Color.LawnGreen;
            this.progressBar1.Location = new System.Drawing.Point(454, 95);
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Size = new System.Drawing.Size(301, 23);
            this.progressBar1.TabIndex = 6;
            // 
            // txtProgress
            // 
            this.txtProgress.AutoSize = true;
            this.txtProgress.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtProgress.Location = new System.Drawing.Point(771, 95);
            this.txtProgress.Name = "txtProgress";
            this.txtProgress.Size = new System.Drawing.Size(80, 17);
            this.txtProgress.TabIndex = 7;
            this.txtProgress.Text = "progress %";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1108, 619);
            this.Controls.Add(this.txtProgress);
            this.Controls.Add(this.progressBar1);
            this.Controls.Add(this.btnETL);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtResults);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnSelectFolder);
            this.Controls.Add(this.txtFolderPath);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox txtFolderPath;
        private System.Windows.Forms.Button btnSelectFolder;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.FolderBrowserDialog folderBrowserDialog1;
        private System.Windows.Forms.TextBox txtResults;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnETL;
        private System.ComponentModel.BackgroundWorker backgroundWorker2;
        private System.Windows.Forms.ProgressBar progressBar1;
        private System.Windows.Forms.Label txtProgress;
    }
}

