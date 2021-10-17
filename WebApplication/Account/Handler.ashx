<%@ WebHandler Language="C#" Class="Handler" %>
using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.IO;
using DataLayer;

public class Handler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context)
    {
       
    } 
    public bool IsReusable {
        get {
            return false;
        }
    }

}