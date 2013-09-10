using System.Windows.Forms;

namespace DC.Forms
{
    partial class Main : System.Windows.Forms.Form
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Main));
            this.fileMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.QLTCD_ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.báoCáoToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.importFileExcelToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.HTDC_ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.menuStrip = new System.Windows.Forms.MenuStrip();
            this.dangnhapStripMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.thoatStripMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.hethongMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.menuStrip.SuspendLayout();
            this.SuspendLayout();
            // 
            // fileMenu
            // 
            this.fileMenu.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.QLTCD_ToolStripMenuItem,
            this.báoCáoToolStripMenuItem,
            this.importFileExcelToolStripMenuItem,
            this.HTDC_ToolStripMenuItem});
            this.fileMenu.Name = "fileMenu";
            this.fileMenu.Size = new System.Drawing.Size(59, 20);
            this.fileMenu.Text = "Công cụ";
            // 
            // QLTCD_ToolStripMenuItem
            // 
            this.QLTCD_ToolStripMenuItem.Name = "QLTCD_ToolStripMenuItem";
            this.QLTCD_ToolStripMenuItem.Size = new System.Drawing.Size(172, 22);
            this.QLTCD_ToolStripMenuItem.Text = "Quản lý chuyển đổi ";
            this.QLTCD_ToolStripMenuItem.Click += new System.EventHandler(this.QLTCD_ToolStripMenuItem_Click);
            // 
            // báoCáoToolStripMenuItem
            // 
            this.báoCáoToolStripMenuItem.Name = "báoCáoToolStripMenuItem";
            this.báoCáoToolStripMenuItem.Size = new System.Drawing.Size(172, 22);
            this.báoCáoToolStripMenuItem.Text = "Báo cáo";
            // 
            // importFileExcelToolStripMenuItem
            // 
            this.importFileExcelToolStripMenuItem.Name = "importFileExcelToolStripMenuItem";
            this.importFileExcelToolStripMenuItem.Size = new System.Drawing.Size(172, 22);
            this.importFileExcelToolStripMenuItem.Text = "Import File Excel";
            this.importFileExcelToolStripMenuItem.Click += new System.EventHandler(this.importFileExcelToolStripMenuItem_Click);
            // 
            // HTDC_ToolStripMenuItem
            // 
            this.HTDC_ToolStripMenuItem.Name = "HTDC_ToolStripMenuItem";
            this.HTDC_ToolStripMenuItem.Size = new System.Drawing.Size(172, 22);
            this.HTDC_ToolStripMenuItem.Text = "Hỗ trợ đối chiếu";
            this.HTDC_ToolStripMenuItem.Click += new System.EventHandler(this.HTDC_ToolStripMenuItem_Click);
            // 
            // menuStrip
            // 
            this.menuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.hethongMenu,
            this.fileMenu});
            this.menuStrip.Location = new System.Drawing.Point(0, 0);
            this.menuStrip.Name = "menuStrip";
            this.menuStrip.Size = new System.Drawing.Size(1016, 24);
            this.menuStrip.TabIndex = 0;
            this.menuStrip.Text = "MenuStrip";
            // 
            // dangnhapStripMenu
            // 
            this.dangnhapStripMenu.Name = "dangnhapStripMenu";
            this.dangnhapStripMenu.Size = new System.Drawing.Size(152, 22);
            this.dangnhapStripMenu.Text = "Đăng Nhập";
            // 
            // thoatStripMenu
            // 
            this.thoatStripMenu.Name = "thoatStripMenu";
            this.thoatStripMenu.Size = new System.Drawing.Size(152, 22);
            this.thoatStripMenu.Text = "Thoát";
            this.thoatStripMenu.Click += new System.EventHandler(this.ExitToolsStripMenuItem_Click);
            // 
            // hethongMenu
            // 
            this.hethongMenu.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.dangnhapStripMenu,
            this.thoatStripMenu});
            this.hethongMenu.ImageTransparentColor = System.Drawing.SystemColors.ActiveBorder;
            this.hethongMenu.Name = "hethongMenu";
            this.hethongMenu.Size = new System.Drawing.Size(67, 20);
            this.hethongMenu.Text = "Hệ Thống";
            // 
            // Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.ClientSize = new System.Drawing.Size(1016, 734);
            this.Controls.Add(this.menuStrip);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.IsMdiContainer = true;
            this.MainMenuStrip = this.menuStrip;
            this.MaximizeBox = false;
            this.Name = "Main";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "FIS PFS -Deploy TMS";
            this.menuStrip.ResumeLayout(false);
            this.menuStrip.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }
        #endregion

        private ToolStripMenuItem fileMenu;
        private ToolStripMenuItem QLTCD_ToolStripMenuItem;
        private MenuStrip menuStrip;
        private ToolStripMenuItem báoCáoToolStripMenuItem;
        private ToolStripMenuItem importFileExcelToolStripMenuItem;
        private ToolStripMenuItem HTDC_ToolStripMenuItem;
        private ToolStripMenuItem hethongMenu;
        private ToolStripMenuItem dangnhapStripMenu;
        private ToolStripMenuItem thoatStripMenu;


    }
}



