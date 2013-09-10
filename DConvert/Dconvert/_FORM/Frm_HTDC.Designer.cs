namespace DC.Forms
{
    partial class Frm_HTDC
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
            this.fbd = new System.Windows.Forms.FolderBrowserDialog();
            this.lb_path = new System.Windows.Forms.Label();
            this.tb_path = new System.Windows.Forms.TextBox();
            this.btn_browse = new System.Windows.Forms.Button();
            this.btn_import = new System.Windows.Forms.Button();
            this.btn_cancel = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // fbd
            // 
            this.fbd.RootFolder = System.Environment.SpecialFolder.MyComputer;
            this.fbd.SelectedPath = "E:\\HTDC";
            // 
            // lb_path
            // 
            this.lb_path.AutoSize = true;
            this.lb_path.Location = new System.Drawing.Point(12, 48);
            this.lb_path.Name = "lb_path";
            this.lb_path.Size = new System.Drawing.Size(32, 13);
            this.lb_path.TabIndex = 0;
            this.lb_path.Text = "Path:";
            // 
            // tb_path
            // 
            this.tb_path.Location = new System.Drawing.Point(50, 45);
            this.tb_path.Name = "tb_path";
            this.tb_path.Size = new System.Drawing.Size(317, 20);
            this.tb_path.TabIndex = 1;
            // 
            // btn_browse
            // 
            this.btn_browse.Location = new System.Drawing.Point(373, 42);
            this.btn_browse.Name = "btn_browse";
            this.btn_browse.Size = new System.Drawing.Size(75, 23);
            this.btn_browse.TabIndex = 2;
            this.btn_browse.Text = "Browse";
            this.btn_browse.UseVisualStyleBackColor = true;
            this.btn_browse.Click += new System.EventHandler(this.btn_browse_Click);
            // 
            // btn_import
            // 
            this.btn_import.Location = new System.Drawing.Point(113, 108);
            this.btn_import.Name = "btn_import";
            this.btn_import.Size = new System.Drawing.Size(75, 23);
            this.btn_import.TabIndex = 3;
            this.btn_import.Text = "Import";
            this.btn_import.UseVisualStyleBackColor = true;
            this.btn_import.Click += new System.EventHandler(this.btn_import_Click);
            // 
            // btn_cancel
            // 
            this.btn_cancel.Location = new System.Drawing.Point(222, 108);
            this.btn_cancel.Name = "btn_cancel";
            this.btn_cancel.Size = new System.Drawing.Size(75, 23);
            this.btn_cancel.TabIndex = 4;
            this.btn_cancel.Text = "Cancel";
            this.btn_cancel.UseVisualStyleBackColor = true;
            this.btn_cancel.Click += new System.EventHandler(this.btn_cancel_Click);
            // 
            // Frm_HTDC
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(562, 273);
            this.Controls.Add(this.btn_cancel);
            this.Controls.Add(this.btn_import);
            this.Controls.Add(this.btn_browse);
            this.Controls.Add(this.tb_path);
            this.Controls.Add(this.lb_path);
            this.Name = "Frm_HTDC";
            this.Text = "Frm_HTDC";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.FolderBrowserDialog fbd;
        private System.Windows.Forms.Label lb_path;
        private System.Windows.Forms.TextBox tb_path;
        private System.Windows.Forms.Button btn_browse;
        private System.Windows.Forms.Button btn_import;
        private System.Windows.Forms.Button btn_cancel;
    }
}