using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace WebLayer
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            RegisterRoutes(System.Web.Routing.RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
        void RegisterRoutes(System.Web.Routing.RouteCollection routes)
        {
            #region Common
            routes.MapPageRoute("", "مدرسه_یاب", "~/Default.aspx");
            routes.MapPageRoute("", "خانه", "~/Default.aspx");
            routes.MapPageRoute("", "home", "~/Default.aspx");

            routes.MapPageRoute("", "آلبوم", "~/Role/Guest/Common/Photo.aspx");
            routes.MapPageRoute("", "آلبوم/{categoryid}/{categorytitle}", "~/Role/Guest/Common/Photo.aspx?CategoryId=$1&amp;CategoryTitle=$2");

            routes.MapPageRoute("", "خبر", "~/Role/Guest/Common/News.aspx");
            routes.MapPageRoute("", "خبر/{newsid}/{newstitle}", "~/Role/Guest/Common/News.aspx?NewsId=$1&amp;NewsTitle=$2");

            routes.MapPageRoute("", "دانستنی", "~/Role/Guest/Common/Blog.aspx");
            routes.MapPageRoute("", "دانستنی/{blogid}/{blogtitle}", "~/Role/Guest/Common/Blog.aspx?BlogId=$1&amp;BlogTitle=$2");
            routes.MapPageRoute("", "دانستنی/{blogid}/{blogtitle}/{schoolid}", "~/Role/Guest/Common/Blog.aspx?BlogId=$1&amp;BlogTitle=$2&amp;SchoolId=$3");

            routes.MapPageRoute("", "ورود", "~/Account/Login.aspx");

            routes.MapPageRoute("", "page/{id}/{title}", "~/Role/Guest/Common/DynamicPage.aspx?PageId=$1&amp;PageTitle=$2");
            #endregion

            #region School
            routes.MapPageRoute("", "{schoolid}", "~/Role/Guest/School/Information.aspx?Id=$1");
            routes.MapPageRoute("", "{schoolid}/مدرسه", "~/Role/Guest/School/Information.aspx?Id=$1");
            routes.MapPageRoute("", "{schoolid}/بلاگ", "~/Role/Guest/Common/Blog.aspx?SchoolId=$1");
            routes.MapPageRoute("", "{schoolid}/آلبوم", "~/Role/Guest/Common/PhotoCategory.aspx?SchoolId=$1");
            routes.MapPageRoute("", "{schoolid}/اخبار_مدرسه", "~/Role/Guest/Common/News.aspx?SchoolId=$1");
            ///مدرسه/1
            //routes.MapPageRoute("", "{schoolid}/اخبار_مدرسه", "~/Role/Guest/Common/News.aspx?SchoolId=$1&amp;NewsId=$2");
            //routes.MapPageRoute("", "بلاگ/{schoolid}/{blogid}", "~/Role/Guest/Common/Blog.aspx?SchoolId=$1&amp;BlogId=$2");
            #endregion
        }
    }
}