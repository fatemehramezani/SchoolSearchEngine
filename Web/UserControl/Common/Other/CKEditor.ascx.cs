using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_Common_Other_CKEditor : System.Web.UI.UserControl
{
    #region ToolbarType
    public enum ToolbarType
    {
        Full = 1,
        Basic = 2
    }
    #endregion

    #region CssClass
    public String CssClass
    {
        get { return CKEditor1.CssClass; }
        set { CKEditor1.CssClass = value; }
    }
    #endregion

    #region ContentsLangDirection
    public CKEditor.NET.contentsLangDirections ContentsLangDirection
    {
        get { return CKEditor1.ContentsLangDirection; }
        set { CKEditor1.ContentsLangDirection = value; }
    }
    #endregion

    #region Config
    public CKEditor.NET.CKEditorConfig Config
    {
        get { return this.CKEditor1.config; }
        set { this.CKEditor1.config = value; }
    }
    #endregion

    #region toolbar
    public Object toolbar
    {
        get { return this.CKEditor1.config.toolbar; }
        set { this.CKEditor1.config.toolbar = value; }
    }
    #endregion

    #region Width
    public Unit Width
    {
        get { return this.CKEditor1.Width; }
        set { this.CKEditor1.Width = value; }
    }
    #endregion

    #region Height
    public Unit Height
    {
        get { return this.CKEditor1.Height; }
        set { this.CKEditor1.Height = value; }
    }
    #endregion

    #region Text
    public String Text
    {
        get { return this.CKEditor1.Text; }
        set { this.CKEditor1.Text = value; }
    }
    #endregion

    #region CKEditor
    public CKEditor.NET.CKEditorControl CKEditor
    {
        get { return this.CKEditor1; }
    }
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}