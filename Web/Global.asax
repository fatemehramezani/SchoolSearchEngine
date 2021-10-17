<%@ Application Language="C#" %>
<script RunAt="server">
    Dictionary<string, string> crum = null;

    protected void Application_BeginRequest(object sender, EventArgs e)
    {
        //var persianCulture = new PersianCulture();
        //System.Threading.Thread.CurrentThread.CurrentCulture = persianCulture;
        //System.Threading.Thread.CurrentThread.CurrentUICulture = persianCulture;
    }

    void Application_PreRequestHandlerExecute(object src, EventArgs e)
    {
        Page p = this.Context.Handler as Page;
        if (p != null)
        {
            p.PreInit += (s, ev) =>
            {
                if (p.MasterPageFile == "/App_MasterPage/PanelMasterPage.master")
                    p.Theme = "Panel";
            };
        }
    }
    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        ///  Application["NoOfVisitors"] = 0;      
        RegisterRoutes(System.Web.Routing.RouteTable.Routes);
    }

    void RegisterRoutes(System.Web.Routing.RouteCollection routes)
    {
        #region Common
        routes.MapPageRoute("", "مدرسه_یاب", "~/Default.aspx");
        routes.MapPageRoute("", "خانه", "~/Default.aspx");
        routes.MapPageRoute("", "home", "~/Default.aspx");
        routes.MapPageRoute("", "rss", "~/Role/Guest/Common/RSS.aspx");
        routes.MapPageRoute("", "sitemap", "~/SiteMaps/SiteMap.aspx");

        routes.MapPageRoute("", "آلبوم", "~/Role/Guest/Common/PhotoCategory.aspx");
        routes.MapPageRoute("", "آلبوم/{categoryid}/{categorytitle}", "~/Role/Guest/Common/PhotoCategory.aspx?CategoryId=$1&amp;CategoryTitle=$2");
        routes.MapPageRoute("", "آلبوم/{categoryid}/{categorytitle}/{schoolid}", "~/Role/Guest/Common/PhotoCategory.aspx?CategoryId=$1&amp;CategoryTitle=$2&amp;SchoolId=$3");

        routes.MapPageRoute("", "خبر", "~/Role/Guest/Common/News.aspx");
        routes.MapPageRoute("", "خبر/{newsid}/{newstitle}", "~/Role/Guest/Common/News.aspx?NewsId=$1&amp;NewsTitle=$2");
        routes.MapPageRoute("", "خبر/{newsid}/{newstitle}/{schoolid}", "~/Role/Guest/Common/News.aspx?NewsId=$1&amp;NewsTitle=$2&amp;SchoolId=$3");

        routes.MapPageRoute("", "معلم", "~/Role/Guest/Common/Teacher.aspx");
        routes.MapPageRoute("", "معلم/{teacherid}/{teachertitle}", "~/Role/Guest/Common/Teacher.aspx?TeacherId=$1&amp;TeacherTitle=$2");
        routes.MapPageRoute("", "معلم/{teacherid}/{teachertitle}/{schoolid}", "~/Role/Guest/Common/Teacher.aspx?TeacherId=$1&amp;TeacherTitle=$2&amp;SchoolId=$3");

        routes.MapPageRoute("", "برتر", "~/Role/Guest/Common/Student.aspx");
        routes.MapPageRoute("", "برتر/{studentid}/{studenttitle}", "~/Role/Guest/Common/Student.aspx?StudentId=$1&amp;StudentTitle=$2");
        routes.MapPageRoute("", "برتر/{studentid}/{studenttitle}/{schoolid}", "~/Role/Guest/Common/Student.aspx?StudentId=$1&amp;StudentTitle=$2&amp;SchoolId=$3");

        routes.MapPageRoute("", "دانستنی", "~/Role/Guest/Common/Blog.aspx");
        routes.MapPageRoute("", "دانستنی/{blogid}/{blogtitle}", "~/Role/Guest/Common/Blog.aspx?BlogId=$1&amp;BlogTitle=$2");
        routes.MapPageRoute("", "دانستنی/{blogid}/{blogtitle}/{schoolid}", "~/Role/Guest/Common/Blog.aspx?BlogId=$1&amp;BlogTitle=$2&amp;SchoolId=$3");

        routes.MapPageRoute("", "ورود", "~/Login.aspx");

        routes.MapPageRoute("", "page/{id}/{title}", "~/Role/Guest/Common/DynamicPage.aspx?PageId=$1&amp;PageTitle=$2");
        #endregion

        #region School
        routes.MapPageRoute("", "{schoolid}", "~/Role/Guest/School/Information.aspx?Id=$1");
        routes.MapPageRoute("", "{schoolid}/مدرسه", "~/Role/Guest/School/Information.aspx?Id=$1");
        routes.MapPageRoute("", "{schoolid}/بلاگ", "~/Role/Guest/Common/Blog.aspx?SchoolId=$1");
        routes.MapPageRoute("", "{schoolid}/معلم", "~/Role/Guest/Common/Teacher.aspx?SchoolId=$1");
        routes.MapPageRoute("", "{schoolid}/برتر", "~/Role/Guest/Common/Student.aspx?SchoolId=$1");
        routes.MapPageRoute("", "{schoolid}/اخبار_مدرسه", "~/Role/Guest/Common/News.aspx?SchoolId=$1");
        routes.MapPageRoute("", "{schoolid}/آلبوم", "~/Role/Guest/Common/PhotoCategory.aspx?SchoolId=$1");
        #endregion

        #region Search
        //routes.MapPageRoute("", "search/{filtertype}/{filtervalue}", "~/Role/Guest/School/SearchResult.aspx?FilterType=$1&amp;FilterValue=$2");
        routes.MapPageRoute("", "search/{filters}", "~/Role/Guest/School/SearchResult.aspx?Filters=$1&amp;");

        #endregion
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }
    void Application_Error(object sender, EventArgs e)
    {
        //Handler.ExceptionHandler exceptionHandler = new Handler.ExceptionHandler((Context.AllErrors[0].GetBaseException() == null ? new Exception("No Error Found") : Context.AllErrors[0].GetBaseException()), Request.AppRelativeCurrentExecutionFilePath);
        //string innerException = exceptionHandler.Exception.Message.ToString();
        //if (innerException.Contains("\'"))
        //    innerException = innerException.Substring(0, innerException.IndexOf('\''));
        //if (innerException.Contains("\""))
        //    innerException = innerException.Substring(0, innerException.IndexOf('\"'));
        //if (innerException == string.Empty)
        //    innerException = exceptionHandler.Exception.Message.ToString();

        //Response.Redirect(string.Format("~/Exception/ExceptionHandler.aspx?Error={0}&PageUrl={1}", innerException, Request.AppRelativeCurrentExecutionFilePath));



        // Code that runs when an unhandled error occurs
        //try
        //{        
        //bool IsValid = (Session["ExceptionHandler"] == null);
        //System.Collections.Generic.List<Handler.ExceptionHandler> exceptionHandlers = new System.Collections.Generic.List<Handler.ExceptionHandler>();            
        // exceptionHandlers.Add(new Handler.ExceptionHandler((Context.AllErrors[0].GetBaseException() == null ? new Exception("No Error Found") : Context.AllErrors[0].GetBaseException()),Request.AppRelativeCurrentExecutionFilePath));
        // Session["ExceptionHandler"] = exceptionHandlers;
        ////
        ////"~/ExceptionManagement/ExceptionHandler.aspx?Error=" + exceptionHandlers 

        // string redirectURL = (IsValid ? Request.AppRelativeCurrentExecutionFilePath : "~/FatalError.aspx");
        //Response.Redirect((Request.QueryString.Count == 0 ? redirectURL : redirectURL + "?" + Request.QueryString.ToString()));
        //}
        //catch
        //{
        //    Session["ExceptionHandler"] = null;
        //}
    }

    void Session_Start(object sender, EventArgs e)
    {
        //Session["ExceptionHandler"] = null;
        ///////////////////////////////////
        // Application.Lock();
        //  Application["NoOfVisitors"] = (int)Application["NoOfVisitors"] + 1;
        //  Application.UnLock();
    }
    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

</script>
