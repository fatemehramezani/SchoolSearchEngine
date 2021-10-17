namespace Crawler
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
            this.findLinkButton = new System.Windows.Forms.Button();
            this.firstChildCheckBox = new System.Windows.Forms.CheckBox();
            this.button1 = new System.Windows.Forms.Button();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.SuspendLayout();
            // 
            // findLinkButton
            // 
            this.findLinkButton.Location = new System.Drawing.Point(75, 22);
            this.findLinkButton.Name = "findLinkButton";
            this.findLinkButton.Size = new System.Drawing.Size(149, 44);
            this.findLinkButton.TabIndex = 1;
            this.findLinkButton.Text = "یافتن لینک ها";
            this.findLinkButton.UseVisualStyleBackColor = true;
            this.findLinkButton.Click += new System.EventHandler(this.findLinkButton_Click);
            // 
            // firstChildCheckBox
            // 
            this.firstChildCheckBox.AutoSize = true;
            this.firstChildCheckBox.Checked = true;
            this.firstChildCheckBox.CheckState = System.Windows.Forms.CheckState.Checked;
            this.firstChildCheckBox.Location = new System.Drawing.Point(115, 72);
            this.firstChildCheckBox.Name = "firstChildCheckBox";
            this.firstChildCheckBox.Size = new System.Drawing.Size(81, 21);
            this.firstChildCheckBox.TabIndex = 2;
            this.firstChildCheckBox.Text = "firstChild";
            this.firstChildCheckBox.UseVisualStyleBackColor = true;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(291, 22);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(149, 44);
            this.button1.TabIndex = 3;
            this.button1.Text = "یافتن تگ";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "openFileDialog1";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(509, 136);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.firstChildCheckBox);
            this.Controls.Add(this.findLinkButton);
            this.Font = new System.Drawing.Font("Tahoma", 8F);
            this.Name = "Form1";
            this.Text = "جستجوی سایت های مدارس";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Button findLinkButton;
        private System.Windows.Forms.CheckBox firstChildCheckBox;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
    }
}

