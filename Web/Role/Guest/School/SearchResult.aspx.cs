using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utility.Search;

namespace Role.Guest.School
{
    public partial class SearchResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadSchoolInformation();
                LoadLastSchoolInformation();
            }
        }
        void LoadSchoolInformation()
        {
            string filters = HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.Filters].ToString();

            string cacheName = string.Format("Search_{0}", filters);
            var schoolList = CachingLayer.Caching.GetFromCache(cacheName) as List<DataLayer.Information>;

            #region Filtering
            if (schoolList == null)
            {
                ICollection<AbstractSearch> searchCriterias = new List<AbstractSearch>();
                try
                {
                    #region Filters                
                    List<string> filterList = new List<string>();
                    if (!string.IsNullOrEmpty(filters))
                        filterList = filters.Split(new char[] { '&' }, StringSplitOptions.RemoveEmptyEntries).ToList();
                    #endregion
                    string filterType = string.Empty;
                    string filterValue = string.Empty;
                    string filterText = string.Empty;

                    foreach (var filter in filterList)
                    {
                        filterType = filter.Split('=')[0];
                        filterValue = filter.Split('=')[1];
                        #region FilterTypes
                        switch (filterType)
                        {
                            case "schoolid":
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(int), "Id", filterValue));
                                break;
                            case "id":
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(int), "Id", filterValue));
                                break;
                            case "provience":
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(int), "ProvienceId", filterValue));
                                break;
                            case "city":
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(int), "CityId", filterValue));
                                break;
                            case "region":
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(int), "RegionId", filterValue));
                                break;
                            case "name":
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(string), "Name", filterValue.Replace("مدرسه-", string.Empty).Replace("-", " ")));
                                break;
                            case "gender":
                                filterText = string.Format(@"<Common_Gender Id=""{0}"">", filterValue);
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(string), "Features", filter));
                                break;
                            case "section":
                                filterText = string.Format(@"<Common_Section Id=""{0}"">", filterValue);
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(string), "Features", filter));
                                break;
                            case "branch":
                                filterText = string.Format(@"<Common_Branch Id=""{0}"">", filterValue);
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(string), "Features", filter));
                                break;
                            case "type":
                                filterText = string.Format(@"<Common_Type Id=""{0}"">", filterValue);
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(string), "Features", filter));
                                break;
                            case "level":
                                filterText = string.Format(@"<Common_Level Id=""{0}"">", filterValue);
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(string), "Features", filter));
                                break;
                            case "filterid":
                                filterText = string.Format(@"<Common_{1} Id=""{0}"">", filterValue, new Service.CommonService().CommonAscendant(int.Parse(filterValue)).Name);
                                searchCriterias.Union(new BusinessLayer.School.SchoolInformations().SetSearchCriteria(searchCriterias, typeof(string), "Features", filter));
                                break;
                            default:
                                break;
                        }
                        #endregion
                    }           
                }
                catch (Exception ex)
                {

                }
                finally
                {
                    schoolList = new BusinessLayer.School.SchoolInformations().Get(searchCriterias).Distinct().ToList();
                    CachingLayer.Caching.AddToCache(cacheName, schoolList, new TimeSpan(1, 0, 0, 0));
                }
            }
            #endregion

            #region Paging
            int recordCount = schoolList.Count();
            if (schoolList != null && recordCount > 0)
            {
                int SearchPageSize = int.Parse(Utility.Common.GetConfigValue("SearchPageSize"));

                pagingControl.PageSize = SearchPageSize;
                pagingControl.RecordCount = recordCount;

                InformationRepeater.DataSource = schoolList.OrderBy(s => s.Name).Skip((pagingControl.PageIndex - 1) * pagingControl.PageSize).Take(pagingControl.PageSize).ToList();
                InformationRepeater.DataBind();
            }
            #endregion
        }
        void LoadLastSchoolInformation()
        {
            string cacheName = "School";
            var schoolList = CachingLayer.Caching.GetFromCache(cacheName) as List<DataLayer.Information>;

            #region Empty Cache
            if (schoolList == null)
            {
                schoolList = new BusinessLayer.School.SchoolInformations().Get().Distinct().ToList();
                CachingLayer.Caching.AddToCache(cacheName, schoolList, new TimeSpan(1, 0, 0, 0));
            }
            #endregion 
            LastRepeater.DataSource = schoolList.Take(5).ToList();
            LastRepeater.DataBind();
        }
    }
}