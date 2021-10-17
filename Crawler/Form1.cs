using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.Threading;
using HtmlAgilityPack;

namespace Crawler
{
    public partial class Form1 : Form
    {
        List<string> allLinks = new List<string>();
        List<string> allTables = new List<string>();

        public Form1()
        {
            InitializeComponent();
        }

        private void findLinkButton_Click(object sender, EventArgs e)
        {
            try
            {
                string link = string.Empty;
                if (openFileDialog1.ShowDialog() == DialogResult.OK)
                {
                    link = openFileDialog1.FileName;
                }
                if (link.Contains(".htm"))
                {
                    WebBrowser wb = new WebBrowser();
                    wb.Url = new Uri(link);
                    wb.DocumentCompleted += wb_DocumentCompleted;
                }
                else
                {
                    TextReader tw1 = new StreamReader(link);
                    string line;
                    while ((line = tw1.ReadLine()) != null)
                    {
                        WebBrowser wb = new WebBrowser();
                        wb.Url = new Uri(line);
                        wb.DocumentCompleted += wb_DocumentCompleted;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }

        void wb_DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs e)
        {
            System.Windows.Forms.HtmlDocument source = ((WebBrowser)sender).Document;
            //List<string> links = extractLink(source).Where(s => s.Contains("http://madreseha.ir/") && s.Contains("ArticleCategory")).Distinct().ToList();
            List<string> links = extractLink(source).Where(s => s.Contains("http://madreseha.ir/tabid/") && s.Contains("ArticleId")).Distinct().ToList();

            if (links != null && links.Count > 1)
            {
                #region Log
                TextWriter tw1 = new StreamWriter($"c:\\Log\\Crawler\\{DateTime.Now.Hour}.txt", true);
                tw1.WriteLine(links.Aggregate((i, j) => i + "\n" + j));
                tw1.Close();
                #endregion
            }
            if (!firstChildCheckBox.Checked)
            {
                WebBrowser wb = new WebBrowser();
                foreach (var link in links)
                {
                    wb.Url = new Uri(link);
                    wb.DocumentCompleted += wb_DocumentCompleted;
                }
            }
        }

        private List<string> extractLink(System.Windows.Forms.HtmlDocument source)
        {
            List<string> links = new List<string>();
            HtmlElementCollection anchorList = source.GetElementsByTagName("a");
            string href;
            foreach (var item in anchorList)
            {
                href = ((HtmlElement)item).GetAttribute("href");
                if (href.Length > 15 && href.Contains("http://madreseha.ir/tabid") && allLinks.Count(s => s == href) == 0)
                {
                    allLinks.Add(href);
                    links.Add(href);
                }
            }
            return links;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                string link = string.Empty;
                if (openFileDialog1.ShowDialog() == DialogResult.OK)
                {
                    link = openFileDialog1.FileName;
                }
                string tables = string.Empty;
                if (link.Contains(".htm"))
                {
                    ReadTableText(link);
                }
                else if (link.Contains(".txt"))
                {
                    TextReader tw1 = new StreamReader(link);
                    string line;
                    while ((line = tw1.ReadLine()) != null)
                         ReadTableText(line);
                }
                MessageBox.Show("Start to write...");
                if (allTables != null && allTables.Count > 0)
                    tables += allTables.Aggregate((i, j) => i + "<br/>" + j);
                WriteHtml(tables);
                MessageBox.Show("End");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
        }
        void WriteHtml(string content)
        {
            var newdoc = new HtmlAgilityPack.HtmlDocument();
            var html = HtmlNode.CreateNode("<html><head></head><body></body></html>");
            newdoc.DocumentNode.AppendChild(html);
            var body = newdoc.DocumentNode.SelectSingleNode("/html/body");
            var div = HtmlNode.CreateNode($@"<div style=""background-color:green"">Results</div>");
            body.AppendChild(div);
            var tabletag = HtmlNode.CreateNode(content);
            body.AppendChild(tabletag);
            newdoc.Save($"result{DateTime.Now.Minute - DateTime.Now.Second}.htm");
        }
        void ReadTableHtml(string url)
        {
            HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
            doc.Load(url);
            var tables = doc.DocumentNode.SelectNodes("//table");
            if (tables == null)
            {
                MessageBox.Show("NoTable");
            }
            string outerHtml = string.Empty;
            foreach (var table in tables)
                allTables.Add(table.OuterHtml + "<hr/><hr/>");
        }
        void ReadTableText(string url)
        {
            WebBrowser wb = new WebBrowser();
            wb.Url = new Uri(url);
            wb.DocumentCompleted += wb_read_DocumentCompleted;
        }
        void wb_read_DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs e)
        {
            System.Windows.Forms.HtmlDocument doc = ((WebBrowser)sender).Document;
            var tables = doc.GetElementsByTagName("table");
            if (tables == null)
            {
                MessageBox.Show("NoTable");
            }
            foreach (var table in tables)
                allTables.Add(((HtmlElement)table).OuterHtml + "<hr/><hr/>");
        }
    }
}
