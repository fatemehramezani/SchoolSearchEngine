using System.Configuration;
using System;
using System.Linq;
using DataLayer;

public partial class Exception_ExceptionHandler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //try
            //{
            //    if (Session["ExceptionHandler"] != null)
            //     //if(Request.QueryString["Error"] != null)
            //    {
            //        List<Handler.ExceptionHandler> executionCollection = (List<Handler.ExceptionHandler>)Session["ExceptionHandler"];
            //        DataLayer.ExceptionHandler _ExceptionHandler = new DataLayer.ExceptionHandler();
            //        using (DatabaseEntities _DatabaseEntities = new DatabaseEntities(ConfigurationManager.ConnectionStrings["DatabaseEntities"].ToString()))
            //        {
            //            foreach (Handler.ExceptionHandler exceptionHandler in executionCollection)
            //            {
            //                ReturnHyperLink.NavigateUrl = exceptionHandler.PageUrl;
            //                try
            //                {
            //                    if (exceptionHandler.ExceptionType == ExceptionType.UnHandeled ||
            //                        exceptionHandler.ExceptionType == ExceptionType.PageUrl)
            //                    {
            //                        string innerException = exceptionHandler.Exception.InnerException.Message.ToString();
            //                        if (innerException.Contains("\'"))
            //                            innerException = innerException.Substring(0, innerException.IndexOf('\''));

            //                        if (_DatabaseEntities.ExceptionHandlers.Where(item => item.InnerException.Contains(innerException)).Count() < 1)
            //                            innerException = "Fatal Error";
            //                        _ExceptionHandler = _DatabaseEntities.ExceptionHandlers.Where(item => item.InnerException.Contains(innerException)).First();
            //                    }
            //                    else
            //                    {
            //                        string innerException = exceptionHandler.ExceptionType.ToString();
            //                        if (_DatabaseEntities.ExceptionHandlers.Where(c => c.InnerException == innerException) == null)
            //                            innerException = "Fatal Error";
            //                        _ExceptionHandler = _DatabaseEntities.ExceptionHandlers.Where(c => c.InnerException == innerException).First();
            //                        _ExceptionHandler.Message = string.Format(_ExceptionHandler.Message, exceptionHandler.ParameterTitle);
            //                        _ExceptionHandler.HelpNote = string.Format(_ExceptionHandler.HelpNote, exceptionHandler.ParameterTitle);
            //                    }
            //                    ExceptionHandlerBulletedList.Items.Add(string.Format(@"{0} : {1}. {2}. {3} ", _ExceptionHandler.Title, _ExceptionHandler.Message, _ExceptionHandler.HelpNote,_ExceptionHandler.InnerException.ToString()));
            //                }
            //                catch
            //                {
            //                    ExceptionHandlerBulletedList.Items.Add(string.Format("{0} : {1}. {2}", ConfigurationManager.AppSettings["DefaultExceptionTitle"], ConfigurationManager.AppSettings["DefaultExceptionMessage"], ConfigurationManager.AppSettings["DefaultExceptionHelpNote"]));
            //                }
            //            }
            //        }                
            //    }
            //}
            //catch
            //{
            //    Page.ClientScript.RegisterClientScriptBlock(Page.GetType(), "CloseForm", "window.close();", true);
            //}
            //finally
            //{
            //    Session["ExceptionHandler"] = null;
            //}

            try
            {
                if (Request.QueryString["Error"] != null)
                {
                    string innerException = Request.QueryString["Error"];
                    DataLayer.ExceptionHandler _ExceptionHandler = new DataLayer.ExceptionHandler();
                    using (DatabaseEntities _DatabaseEntities = new DatabaseEntities(ConfigurationManager.ConnectionStrings["DatabaseEntities"].ToString()))
                    {
                        if (Request.QueryString["PageUrl"] != null)
                            ReturnHyperLink.NavigateUrl = Request.QueryString["PageUrl"];
                        else
                            ReturnHyperLink.NavigateUrl = "~/Default.aspx";
                        try
                        {
                            if (_DatabaseEntities.ExceptionHandler.Count(item => item.InnerException.Contains(innerException)) < 1)
                            {
                                TitleLabel.Text = ConfigurationManager.AppSettings["DefaultExceptionTitle"];
                                OriginalMessageLabel.Text = innerException;
                                HelpNoteLabel.Text = ConfigurationManager.AppSettings["DefaultExceptionHelpNote"];
                                MessageLabel.Text = ConfigurationManager.AppSettings["DefaultExceptionMessage"];
                                //  Response.Redirect("~/FatalError.aspx");
                            }
                            _ExceptionHandler = _DatabaseEntities.ExceptionHandler.First(item => item.InnerException.Contains(innerException));
                            TitleLabel.Text = _ExceptionHandler.Title;
                            OriginalMessageLabel.Text = _ExceptionHandler.InnerException;
                            HelpNoteLabel.Text = _ExceptionHandler.HelpNote;
                            MessageLabel.Text = _ExceptionHandler.Message;
                        }
                        catch (Exception exception)
                        {
                            TitleLabel.Text = ConfigurationManager.AppSettings["DefaultExceptionTitle"];
                            OriginalMessageLabel.Text = exception.Message;
                            HelpNoteLabel.Text = ConfigurationManager.AppSettings["DefaultExceptionHelpNote"];
                            MessageLabel.Text = ConfigurationManager.AppSettings["DefaultExceptionMessage"];
                        }
                    }
                }
            }
            catch
            {
                Response.Redirect("~/FatalError.aspx");
            }
        }
    }

