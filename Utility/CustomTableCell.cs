using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace Utility
{
    /// <summary>
    /// Summary description for MyTableCell
    /// </summary>
    public class CustomTableCell : TableCell
    {
        public CustomTableCell(string txt)
            : base()
        {
            this.Text = txt;
        }
        public CustomTableCell(string txt, string Css)
            : base()
        {
            this.Text = txt;
            this.CssClass = Css;
        }
        public CustomTableCell(params Control[] c)
            : base()
        {
            foreach (Control ci in c)
            {
                this.Controls.Add(ci);
            }

        }
        public CustomTableCell(string Css, params Control[] c)
            : base()
        {
            this.CssClass = Css;
            foreach (Control ci in c)
            {
                this.Controls.Add(ci);
            }

        }
    }
}