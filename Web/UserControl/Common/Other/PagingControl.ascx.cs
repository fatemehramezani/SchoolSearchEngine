using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_Common_Other_PagingControl : System.Web.UI.UserControl
{
    private Int32 _PageSize = 20;
    private Int32 _RecordCount = 0;
    private Int32 _PageIndex = 1;

    /// <summary>
    /// اندازه تعداد کل رکوردها
    /// </summary>
    public Int32 RecordCount
    {
        get { return _RecordCount; }
        set { _RecordCount = value; }
    }

    /// <summary>
    /// تعداد رکورد نمایش داده شده در صفحه
    /// مقدار پیش فرض 20 رکورد
    /// </summary>
    public Int32 PageSize
    {
        get { return _PageSize; }
        set { _PageSize = value; }
    }

    /// <summary>
    /// شماره صفحه فعلی
    /// </summary>
    public Int32 PageIndex
    {
        get
        {
            Int32.TryParse(Request.QueryString["page"], out _PageIndex);
            if (_PageIndex <= 0) _PageIndex = 1;
            return _PageIndex;
        }
    }

    //-------------------------------

    #region InitPaging
    private void InitPaging()
    {
        String rawurl = Request.RawUrl;
        //--this method get from:
        //--http://www.codeproject.com/Articles/410733/Custom-paging-with-ASP-NET-GridView
        //string url = String.Format("{0}?", Request.Url.AbsolutePath);
        String url = rawurl.IndexOf("?") > 0 ? String.Format("{0}?", rawurl.Substring(0, rawurl.IndexOf("?"))) : String.Format("{0}?", rawurl);
        //
        List<String> qItems = Request.Url.Query.Replace("?", "").Split(new Char[] { '&' }, StringSplitOptions.RemoveEmptyEntries).Distinct().ToList();
        foreach (var item in qItems)
        {
            var key = item.Split(new Char[] { '=' }, StringSplitOptions.RemoveEmptyEntries);
            if (key[0].ToLower() != "page" && key[0].ToLower() != "size")
                url += String.Format("{0}={1}&", key[0], (key.Count() > 1) ? key[1] : "");
        }

        //
        string link = "<a href='" + url + "Page=##Page##&amp;Size=##Size##'><span class='page-numbers'>##Text##</span></a>";
        string link_pre = "<a href='" + url + "Page=##Page##&amp;Size=##Size##'><span class='page-numbers prev'>##Text##</span></a>";
        string link_next = "<a href='" + url + "Page=##Page##&amp;Size=##Size##'><span class='page-numbers next'>##Text##</span></a>";

        //
        _PageIndex = 1;
        try { _PageIndex = Int32.Parse(Request.QueryString["Page"]); } catch { }
        try { PageSize = Int32.Parse(Request.QueryString["size"]); } catch { }
        Double n = Convert.ToDouble((Double)_RecordCount / (Double)PageSize);
        /////////setting page numbers with links
        //--قبلی
        if (_PageIndex != 1) lblpre.Text = link_pre.Replace("##Size##", PageSize.ToString()).Replace("##Page##", (_PageIndex - 1).ToString()).Replace("##Text##", ">");
        else lblpre.Text = "<span class='page-numbers prev'>></span>";

        //--بعدی
        if ((PageSize * _PageIndex) < RecordCount)
            if (_PageIndex != Convert.ToInt32(n)) lblnext.Text = link_next.Replace("##Size##", PageSize.ToString()).Replace("##Page##", (_PageIndex + 1).ToString()).Replace("##Text##", "<");
            else lblnext.Text = "<span class='page-numbers next'><</span>";

        //generate dynamic paging 
        int start;
        if (_PageIndex <= 5) start = 1;
        else start = _PageIndex - 4;
        for (int i = start; i < start + 7; i++)
        {
            //if (i > n) continue;
            //poya
            if (i > n)
            {
                if ((i - n) > 0 && (i - n) < 1) { /*رقم اعشار می باشد*/ }
                else continue;
                //System.Math.Abs
            }
            //
            //create dynamic HyperLinks 
            HyperLink lnk = new HyperLink();

            lnk.ID = "lnk_" + i.ToString();
            if (i == _PageIndex)//current page
            {
                lnk.CssClass = "page-numbers current";
                lnk.Text = i.ToString();
            }
            else
            {
                lnk.Text = i.ToString();
                lnk.CssClass = "page-numbers";
                lnk.NavigateUrl = url + "Page=" + i + "&Size=" + PageSize + "";
            }
            //add links to page
            this.pl.Controls.Add(lnk);
        }
        //------------------------------------------------------------------
        //set up the ist page and the last page
        if (n > 7)
        {
            if (_PageIndex <= Convert.ToInt32(n / 2))
            {
                lblLast.Visible = true;
                lblIst.Visible = false;
                lblLast.Text = link.Replace("##Page##", ((Int32)n).ToString()).Replace(
                  "##Size##", PageSize.ToString()).Replace("##Text##", ((Int32)n).ToString());
                spDot2.Visible = true;
                spDot1.Visible = false;
            }
            else
            {
                lblLast.Visible = false;
                lblIst.Visible = true;
                lblIst.Text = link.Replace("##Page##", ((Int32)(n - n + 1)).ToString()).Replace(
                  "##Size##", PageSize.ToString()).Replace("##Text##", ((Int32)(n - n + 1)).ToString());
                spDot2.Visible = false;
                spDot1.Visible = true;
            }
        }
    }
    #endregion

    protected override void OnPreRender(EventArgs e)
    {
        this.InitPaging();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}