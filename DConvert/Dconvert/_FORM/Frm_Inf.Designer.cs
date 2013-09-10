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
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.splitContainer2 = new System.Windows.Forms.SplitContainer();
            this.grbStatus = new System.Windows.Forms.GroupBox();
            this.lvwStatus = new System.Windows.Forms.ListView();
            this.cl_action = new System.Windows.Forms.ColumnHeader();
            this.cl_value = new System.Windows.Forms.ColumnHeader();
            this.cl_where_log = new System.Windows.Forms.ColumnHeader();
            this.cl_err_code = new System.Windows.Forms.ColumnHeader();
            this.grbLog = new System.Windows.Forms.GroupBox();
            this.lvwLog = new System.Windows.Forms.ListView();
            this.cl_pck = new System.Windows.Forms.ColumnHeader();
            this.cl_status = new System.Windows.Forms.ColumnHeader();
            this.cl_time = new System.Windows.Forms.ColumnHeader();
            this.cl_error_stack = new System.Windows.Forms.ColumnHeader();
            this.grbBC = new System.Windows.Forms.GroupBox();
            this.lvwBC = new System.Windows.Forms.ListView();
            this.cl_loai = new System.Windows.Forms.ColumnHeader();
            this.cl_tax_model = new System.Windows.Forms.ColumnHeader();
            this.cl_ma_tkhai = new System.Windows.Forms.ColumnHeader();
            this.cl_tmt_ma_tmuc = new System.Windows.Forms.ColumnHeader();
            this.cl_so_tien_duong = new System.Windows.Forms.ColumnHeader();
            this.cl_so_tien_am = new System.Windows.Forms.ColumnHeader();
            this.cl_so_tien = new System.Windows.Forms.ColumnHeader();
            this.cl_sl = new System.Windows.Forms.ColumnHeader();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.splitContainer2.Panel1.SuspendLayout();
            this.splitContainer2.Panel2.SuspendLayout();
            this.splitContainer2.SuspendLayout();
            this.grbStatus.SuspendLayout();
            this.grbLog.SuspendLayout();
            this.grbBC.SuspendLayout();
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
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.splitContainer2);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.grbBC);
            this.splitContainer1.Size = new System.Drawing.Size(943, 651);
            this.splitContainer1.SplitterDistance = 209;
            this.splitContainer1.TabIndex = 1;
            // 
            // splitContainer2
            // 
            this.splitContainer2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer2.Location = new System.Drawing.Point(0, 0);
            this.splitContainer2.Name = "splitContainer2";
            // 
            // splitContainer2.Panel1
            // 
            this.splitContainer2.Panel1.Controls.Add(this.grbStatus);
            // 
            // splitContainer2.Panel2
            // 
            this.splitContainer2.Panel2.Controls.Add(this.grbLog);
            this.splitContainer2.Size = new System.Drawing.Size(943, 209);
            this.splitContainer2.SplitterDistance = 479;
            this.splitContainer2.TabIndex = 0;
            // 
            // grbStatus
            // 
            this.grbStatus.Controls.Add(this.lvwStatus);
            this.grbStatus.Dock = System.Windows.Forms.DockStyle.Fill;
            this.grbStatus.Location = new System.Drawing.Point(0, 0);
            this.grbStatus.Name = "grbStatus";
            this.grbStatus.Size = new System.Drawing.Size(479, 209);
            this.grbStatus.TabIndex = 0;
            this.grbStatus.TabStop = false;
            this.grbStatus.Text = "Status";
            // 
            // lvwStatus
            // 
            this.lvwStatus.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.cl_action,
            this.cl_value,
            this.cl_where_log,
            this.cl_err_code});
            this.lvwStatus.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lvwStatus.Font = new System.Drawing.Font(".VnArial", 9F);
            this.lvwStatus.GridLines = true;
            this.lvwStatus.Location = new System.Drawing.Point(3, 16);
            this.lvwStatus.Name = "lvwStatus";
            this.lvwStatus.Size = new System.Drawing.Size(473, 190);
            this.lvwStatus.TabIndex = 0;
            this.lvwStatus.UseCompatibleStateImageBehavior = false;
            this.lvwStatus.View = System.Windows.Forms.View.Details;
            // 
            // cl_action
            // 
            this.cl_action.Text = "Action";
            this.cl_action.Width = 161;
            // 
            // cl_value
            // 
            this.cl_value.Text = "S";
            this.cl_value.Width = 23;
            // 
            // cl_where_log
            // 
            this.cl_where_log.Text = "Where_log";
            this.cl_where_log.Width = 82;
            // 
            // cl_err_code
            // 
            this.cl_err_code.Text = "Err_code";
            this.cl_err_code.Width = 169;
            // 
            // grbLog
            // 
            this.grbLog.Controls.Add(this.lvwLog);
            this.grbLog.Dock = System.Windows.Forms.DockStyle.Fill;
            this.grbLog.Location = new System.Drawing.Point(0, 0);
            this.grbLog.Name = "grbLog";
            this.grbLog.Size = new System.Drawing.Size(460, 209);
            this.grbLog.TabIndex = 0;
            this.grbLog.TabStop = false;
            this.grbLog.Text = "Log";
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
            this.lvwLog.Location = new System.Drawing.Point(3, 16);
            this.lvwLog.Name = "lvwLog";
            this.lvwLog.Size = new System.Drawing.Size(454, 190);
            this.lvwLog.TabIndex = 0;
            this.lvwLog.UseCompatibleStateImageBehavior = false;
            this.lvwLog.View = System.Windows.Forms.View.Details;
            // 
            // cl_pck
            // 
            this.cl_pck.Text = "Package";
            this.cl_pck.Width = 142;
            // 
            // cl_status
            // 
            this.cl_status.Text = "S";
            this.cl_status.Width = 26;
            // 
            // cl_time
            // 
            this.cl_time.Text = "Timestamp";
            this.cl_time.Width = 155;
            // 
            // cl_error_stack
            // 
            this.cl_error_stack.Text = "Error_stack";
            this.cl_error_stack.Width = 92;
            // 
            // grbBC
            // 
            this.grbBC.Controls.Add(this.lvwBC);
            this.grbBC.Dock = System.Windows.Forms.DockStyle.Fill;
            this.grbBC.Location = new System.Drawing.Point(0, 0);
            this.grbBC.Name = "grbBC";
            this.grbBC.Size = new System.Drawing.Size(943, 438);
            this.grbBC.TabIndex = 0;
            this.grbBC.TabStop = false;
            this.grbBC.Text = "Tổng hợp BC";
            // 
            // lvwBC
            // 
            this.lvwBC.Activation = System.Windows.Forms.ItemActivation.OneClick;
            this.lvwBC.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.cl_loai,
            this.cl_tax_model,
            this.cl_ma_tkhai,
            this.cl_tmt_ma_tmuc,
            this.cl_so_tien_duong,
            this.cl_so_tien_am,
            this.cl_so_tien,
            this.cl_sl});
            this.lvwBC.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lvwBC.Font = new System.Drawing.Font(".VnArial", 9F);
            this.lvwBC.GridLines = true;
            this.lvwBC.HoverSelection = true;
            this.lvwBC.Location = new System.Drawing.Point(3, 16);
            this.lvwBC.Name = "lvwBC";
            this.lvwBC.Size = new System.Drawing.Size(937, 419);
            this.lvwBC.TabIndex = 0;
            this.lvwBC.UseCompatibleStateImageBehavior = false;
            this.lvwBC.View = System.Windows.Forms.View.Details;
            this.lvwBC.SelectedIndexChanged += new System.EventHandler(this.lvwBC_SelectedIndexChanged);
            // 
            // cl_loai
            // 
            this.cl_loai.Text = "Lo¹i";
            this.cl_loai.Width = 70;
            // 
            // cl_tax_model
            // 
            this.cl_tax_model.Text = "Tax Model";
            this.cl_tax_model.Width = 77;
            // 
            // cl_ma_tkhai
            // 
            this.cl_ma_tkhai.Text = "M· tê khai";
            this.cl_ma_tkhai.Width = 100;
            // 
            // cl_tmt_ma_tmuc
            // 
            this.cl_tmt_ma_tmuc.Text = "M· tiÓu môc";
            this.cl_tmt_ma_tmuc.Width = 85;
            // 
            // cl_so_tien_duong
            // 
            this.cl_so_tien_duong.Text = "Sè tiÒn d­¬ng";
            this.cl_so_tien_duong.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.cl_so_tien_duong.Width = 151;
            // 
            // cl_so_tien_am
            // 
            this.cl_so_tien_am.Text = "Sè tiÒn ©m";
            this.cl_so_tien_am.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.cl_so_tien_am.Width = 156;
            // 
            // cl_so_tien
            // 
            this.cl_so_tien.Text = "Sè tiÒn";
            this.cl_so_tien.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.cl_so_tien.Width = 161;
            // 
            // cl_sl
            // 
            this.cl_sl.Text = "Sè l­îng";
            this.cl_sl.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.cl_sl.Width = 100;
            // 
            // Frm_Inf
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(943, 651);
            this.Controls.Add(this.splitContainer1);
            this.Controls.Add(this.lb_inf);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow;
            this.Name = "Frm_Inf";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Load += new System.EventHandler(this.Frm_Inf_Load);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.ResumeLayout(false);
            this.splitContainer2.Panel1.ResumeLayout(false);
            this.splitContainer2.Panel2.ResumeLayout(false);
            this.splitContainer2.ResumeLayout(false);
            this.grbStatus.ResumeLayout(false);
            this.grbLog.ResumeLayout(false);
            this.grbBC.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lb_inf;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.SplitContainer splitContainer2;
        private System.Windows.Forms.GroupBox grbStatus;
        private System.Windows.Forms.GroupBox grbLog;
        private System.Windows.Forms.GroupBox grbBC;
        private System.Windows.Forms.ListView lvwStatus;
        private System.Windows.Forms.ListView lvwLog;
        private System.Windows.Forms.ListView lvwBC;
        private System.Windows.Forms.ColumnHeader cl_action;
        private System.Windows.Forms.ColumnHeader cl_value;
        private System.Windows.Forms.ColumnHeader cl_where_log;
        private System.Windows.Forms.ColumnHeader cl_err_code;
        private System.Windows.Forms.ColumnHeader cl_pck;
        private System.Windows.Forms.ColumnHeader cl_status;
        private System.Windows.Forms.ColumnHeader cl_time;
        private System.Windows.Forms.ColumnHeader cl_error_stack;
        private System.Windows.Forms.ColumnHeader cl_loai;
        private System.Windows.Forms.ColumnHeader cl_tax_model;
        private System.Windows.Forms.ColumnHeader cl_ma_tkhai;
        private System.Windows.Forms.ColumnHeader cl_tmt_ma_tmuc;
        private System.Windows.Forms.ColumnHeader cl_so_tien;
        private System.Windows.Forms.ColumnHeader cl_sl;
        private System.Windows.Forms.ColumnHeader cl_so_tien_duong;
        private System.Windows.Forms.ColumnHeader cl_so_tien_am;
    }
}