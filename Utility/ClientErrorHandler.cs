using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mime;
using System.Text;
using System.Threading.Tasks;

namespace Utility.DataAnnotation
{
    public class ClientErrorHandler : FilterAttribute, IExceptionFilter
    {
        public void OnException(ExceptionContext filterContext)
        {
            var response = filterContext.RequestContext.HttpContext.Response;
            response.Write(filterContext.Exception.InnerException.InnerException.Message);
            response.ContentType = MediaTypeNames.Text.Plain;
          //  filterContext.ExceptionHandled = true;
        }
    }
}
