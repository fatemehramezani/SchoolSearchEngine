using System;
using System.Linq;
using System.Web;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Web.Services;
using System.Web.Services.Protocols;
using AjaxControlToolkit;
using System.Data;
using System.Data.SqlClient;
namespace ServiceLayer
{
    /// <summary>
    /// Summary description for Province
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService()]
    public class CommonService : System.Web.Services.WebService
    {
        public CommonService()
        {
            //Uncomment the following line if using designed components 
            //InitializeComponent(); 
        }

        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public CascadingDropDownNameValue[] GetProvinces(string knownCategoryValues, string category, string contextKey)
        {
            List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
            var q = new BusinessLayer.Common.Locations().GetByProperty(typeof(int), "ParentId", string.Empty);            
            foreach (var item in q)
            {
                values.Add(new CascadingDropDownNameValue(item.Title, item.Id.ToString(), !string.IsNullOrEmpty(contextKey) && item.Id.ToString() == contextKey));
            }
            return values.ToArray();
        }

        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public CascadingDropDownNameValue[] GetCitiesForProvince(string knownCategoryValues, string category, string contextKey)
        {
            StringDictionary categoryValues = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
            int ProvinceId = Convert.ToInt32(categoryValues["ProvinceId"]);
            var q = new BusinessLayer.Common.Locations().GetByProperty(typeof(int),"ParentId",ProvinceId.ToString());
                //.Where(e => e.ProvinceId == ProvinceID).OrderBy(e => e.Name).ToList();
            List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
            foreach (var item in q)
            {
               values.Add(new CascadingDropDownNameValue(item.Title, item.Id.ToString(), !string.IsNullOrEmpty(contextKey) && item.Id.ToString() == contextKey));                
            }
            return values.ToArray();
        }

        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public CascadingDropDownNameValue[] GetRegionsForCity(string knownCategoryValues, string category, string contextKey)
        {
            StringDictionary categoryValues = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
            int CityId = Convert.ToInt32(categoryValues["CityId"]);
            var q = new BusinessLayer.Common.Locations().GetByProperty(typeof(int), "ParentId", CityId.ToString());
            List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
            foreach (var item in q)
            {
                values.Add(new CascadingDropDownNameValue(item.Title, item.Id.ToString(), !string.IsNullOrEmpty(contextKey) && item.Id.ToString() == contextKey));
            }
            return values.ToArray();
        }
    }
}