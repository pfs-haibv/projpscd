namespace DC.Forms
{
    partial class Frm_Inf
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
            this.lb_inf = new System.Windows.Forms.Label();
            this.lvwLog = new System.Windows.Forms.ListView();
            this.cl_pck = new System.Windows.Forms.ColumnHeader();
            this.cl_status = new System.Windows.Forms.ColumnHeader();
            this.cl_time = new System.Windows.Forms.ColumnHeader();
            this.cl_error_stack = new System.Windows.Forms.ColumnHeader();
            this.SuspendLayout();
            // 
            // lb_inf
            // 
            this.lb_inf.AutoSize = true;
            this.lb_inf.Location = new System.Drawing.Point(12, 42);
            this.lb_inf.Name = "lb_inf";
            this.lb_inf.Size = new System.Drawing.Size(0, 13);
            this.lb_inf.TabIndex = 0;
            // 
            // lvwLog
            // 
            this.lvwLog.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.cl_pck,
            this.cl_status,
            this.cl_time,
            this.cl_error_stack});
            this.lvwLog.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lvwLog.Font = new System.Drawing.Font(".VnArial", 9F);
            this.lvwLog.GridLines = true;
            this.lvwLog.Location = new System.Drawing.Point(0, 0);
            this.lvwLog.Name = "lvwLog";
            this.lvwLog.Size = new System.Drawing.Size(943, 651);
            this.lvwLog.TabIndex = 2;
            this.lvwLog.UseCompatibleStateImageBehavior = false;
            this.lvwLog.View = System.Windows.Forms.View.Details;
            // 
            // cl_pck
            // 
            this.cl_pck.Text = "Package";
            this.cl_pck.Width = 169;
            // 
            // cl_status
            // 
            this.cl_status.Text = "S";
            this.cl_status.Width = 36;
            // 
            // cl_time
            // 
            this.cl_time.Text = "Timestamp";
            this.cl_time.Width = 160;
            // 
            // cl_error_stack
            // 
            this.cl_error_stack.Text = "Error_stack";
            this.cl_error_stack.Width = 564;
            // 
            // Frm_Inf
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(943, 651);
            this.Controls.Add(this.lvwLog);
            this.Controls.Add(this.lb_inf);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Name = "Frm_Inf";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Load += new System.EventHandler(this.Frm_Inf_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lb_inf;
        private System.Windows.Forms.ListView lvwLog;
        private System.Windows.Forms.ColumnHeader cl_pck;
        private System.Windows.Forms.ColumnHeader cl_status;
        private System.Windows.Forms.ColumnHeader cl_time;
        private System.Windows.Forms.ColumnHeader cl_error_stack;
    }
}