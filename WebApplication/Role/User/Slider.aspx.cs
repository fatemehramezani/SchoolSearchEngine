using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Image = System.Drawing.Image;
using Utility;
public partial class Admin_Slider : System.Web.UI.Page
{
    protected string imagePath = "~/Files/Slider";
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string request = Request["goto"];
            if (request == null)
                SetImage();
            else if (request == "del")
            {
                DeleteThisfile();
                SetImage();
            }
        }
    }

    private void DeleteThisfile()
    {
        string thisfile = Request["thisfile"];
        string image = Server.MapPath(imagePath + "\\" + thisfile);

        FileInfo fileInfo = new FileInfo(image);
        if (fileInfo.Attributes != FileAttributes.Directory)
            System.IO.File.Delete(image);
        else
            Directory.Delete(image);
    }

    private void SetImage()
    {
        string p = Server.MapPath(imagePath);
        if (!Directory.Exists(p))
        {
            ImageMultiView.SetActiveView(NoFileView);
            return;
        }
        string[] fns = Directory.GetFiles(p);
        string[] dns = Directory.GetDirectories(p);
        string uplevel = imagePath;
        if (uplevel.LastIndexOf("\\") > 0)
            uplevel = uplevel.Substring(0, uplevel.LastIndexOf("\\"));
        ImageTable.Rows.Clear();
        //TODO
        ImageTable.CssClass = "ms-list8-main";
        TableRow tr = new TableRow();
        tr = new TableRow();
        tr.Cells.AddRange(new TableCell[] {                   
        new CustomTableCell("حذف","ms-list8-top"),
        new CustomTableCell("عنوان تصویر","ms-list8-tl")});
        ImageTable.Rows.Add(tr);
        PrintList(dns, false);
        PrintList(fns, true);
        tr = new TableRow();
        CustomTableCell mtc = new CustomTableCell("&nbsp;", "ms-list8-bottom");
        mtc.ColumnSpan = 5;
        tr.Cells.Add(mtc);
        ImageTable.Rows.Add(tr);
        ImageMultiView.SetActiveView(FileView);
    }
    private void PrintList(string[] fns, bool isfiles)
    {
        int i = 1;
        string c = "";
        FileInfo fi = null;
        DirectoryInfo di = null;
        foreach (string fn in fns)
        {
            if (isfiles)
                fi = new FileInfo(fn);
            else
                di = new DirectoryInfo(fn);
            TableRow tr = new TableRow();
            if (i % 2 == 0)
                c = "odd";
            else
                c = "even";

            string ext = fi.Extension;
            string name = ((isfiles) ? fi.Name : di.Name);
            imagePath = imagePath.Replace("/", "\\");
            CustomLinkButton li = new CustomLinkButton(name, imagePath);
            li.CssClass = "filename";
            tr.Cells.AddRange(new TableCell[] {                                          
             new CustomTableCell("ms-list8-"+c,GetButtons(name)),
            new CustomTableCell("ms-list8-left", li)});
            ImageTable.Rows.Add(tr);
            i++;
        }
    }  
    private CustomImageButton[] GetButtons(string f)
    {
        List<CustomImageButton> li = new List<CustomImageButton>();
        li.Add(new CustomImageButton("../App_Themes/Default/images/messagebox_critical.png", "Slider.aspx?goto=del&thisfile=" + f , "حذف"));
        return li.ToArray();

    } 
    private void SaveImages()
    {
        if (!MaxPicFileUpload.HasFile)
            return;

        string imgpath = Server.MapPath(imagePath);
        if (!Directory.Exists(imgpath))
            Directory.CreateDirectory(imgpath);

        string maxFile = imgpath + "\\" + MaxPicFileUpload.FileName;
        System.Drawing.Image maxFullSizeImg = System.Drawing.Image.FromStream(MaxPicFileUpload.PostedFile.InputStream);
        System.Drawing.Image.GetThumbnailImageAbort maxDummyCallBack = new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback);
        System.Drawing.Image maxThumbNailImg = maxFullSizeImg.GetThumbnailImage(Math.Min(maxFullSizeImg.Width, 700), Math.Min(maxFullSizeImg.Height, 500), maxDummyCallBack, IntPtr.Zero);
        maxThumbNailImg.Save(maxFile);

    }
    public bool ThumbnailCallback()
    {
        return false;
    }
    protected void MaxFileCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = (MaxPicFileUpload.FileContent.Length < 400*1024);
    }
    protected void InsertButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            SaveImages();
            SetImage();
        }
    }
}