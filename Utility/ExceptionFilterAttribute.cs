using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Utility.DataAnnotation
{
    public class ExceptionFilterAttribute : FilterAttribute, IExceptionFilter
    {
        public void OnException(ExceptionContext filterContext)
        {
            /*It has no support to log the exceptions since it suppressed the error once it is handled.
            It only catch 500 Http error and doesn't catch other HTTP errors like 404,401 etc.
            It doesn't catch the errors that occur outside the controllers like errors occurs in model.
            It returns error view even if error occurred in AJAX calls that is not useful in the client-side. It would be great to return a piece of JSON in AJAX exceptions */
            if (filterContext.ExceptionHandled || !filterContext.HttpContext.IsCustomErrorEnabled)
            {
                return;
            }
            if (new HttpException(null, filterContext.Exception).GetHttpCode() != 500)
            {
                return;
            }
            //if (!ExceptionType.IsInstanceOfType(filterContext.Exception))
            //{
            //    return;
            //}
            if (filterContext.RequestContext.HttpContext.Request.IsAjaxRequest())
            {
                Exception exception = filterContext.Exception;
                if (filterContext.Exception.InnerException != null)
                    exception = filterContext.Exception.InnerException;
                if (filterContext.Exception.InnerException != null && filterContext.Exception.InnerException.InnerException != null)
                    exception = filterContext.Exception.InnerException.InnerException;
                filterContext.HttpContext.Response.StatusCode = 500;
                filterContext.ExceptionHandled = true;
                filterContext.Result = new JsonResult
                {
                    Data = new
                    {
                        errorMessage = exception.Message
                    },
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet
                };
            }
            else
            {
                var controllerName = (string)filterContext.RouteData.Values["controller"];
                var actionName = (string)filterContext.RouteData.Values["action"];
                var model = new HandleErrorInfo(filterContext.Exception, controllerName, actionName);

                filterContext.Result = new ViewResult
                {
                    ViewName = "Home",
                    ViewData = new ViewDataDictionary(model),
                    TempData = filterContext.Controller.TempData
                };
            }
        }
    }
}
